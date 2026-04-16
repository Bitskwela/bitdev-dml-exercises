# app.py
# ============================================
# LUTO — Streamlit Web App (Full Solution)
# by Dan Santos
# ============================================
# Run: streamlit run act_1.answer.py
# Install: pip install streamlit openai

import os
import json

# ============================================
# Optional: real OpenAI or mock fallback
# ============================================
try:
    from openai import OpenAI as RealOpenAI
    HAS_OPENAI = True
except ImportError:
    HAS_OPENAI = False


class MockOpenAI:
    class chat:
        class completions:
            @staticmethod
            def create(model, messages, **kwargs):
                last = messages[-1]["content"].lower() if messages else ""
                if "rainy" in last:
                    reply = "Sinigang na baboy — perfect for rainy weather! P65/serving."
                elif "magkano" in last or "how much" in last:
                    reply = "Sinigang: P65 sell, P38 cost, P27 profit per serving."
                elif "thank" in last or "salamat" in last:
                    reply = "Walang anuman! Happy cooking!"
                elif "hello" in last or "kumusta" in last:
                    reply = "Kumusta! I'm Luto, your carinderia assistant. Ask me anything!"
                else:
                    reply = "Try Adobo — classic, reliable, always sells."

                class R:
                    class Choice:
                        class Msg:
                            def __init__(s, c): s.content = c
                        def __init__(s, c): s.message = s.Msg(c)
                    def __init__(s, c): s.choices = [s.Choice(c)]
                return R(reply)


def get_client():
    api_key = os.environ.get("OPENAI_API_KEY")
    if HAS_OPENAI and api_key:
        return RealOpenAI(api_key=api_key), False
    return MockOpenAI(), True


SYSTEM_PROMPT = (
    "You are Luto, AI assistant for small Filipino carinderias. "
    "Warm, practical, Taglish-friendly. Use PHP for prices. "
    "Keep answers under 4 sentences."
)


# ============================================
# Try to import Streamlit. If not available,
# print instructions instead of crashing.
# ============================================
try:
    import streamlit as st

    st.set_page_config(page_title="Luto", page_icon="🍲", layout="centered")

    # Cache the client so we don't recreate it every rerun
    @st.cache_resource
    def cached_client():
        return get_client()

    client, mock_mode = cached_client()

    # Session state
    if "history" not in st.session_state:
        st.session_state.history = [{"role": "system", "content": SYSTEM_PROMPT}]
    if "total_tokens" not in st.session_state:
        st.session_state.total_tokens = 0

    # Sidebar
    with st.sidebar:
        st.title("🍲 Luto")
        st.caption("Your AI carinderia assistant")
        mode_label = "🟡 Demo Mode (no API key)" if mock_mode else "🟢 Live API"
        st.info(mode_label)
        user_msgs = [m for m in st.session_state.history if m["role"] == "user"]
        st.metric("Messages", len(user_msgs))
        st.metric("Est. tokens", st.session_state.total_tokens)

        if st.button("🗑️  Clear chat"):
            st.session_state.history = [{"role": "system", "content": SYSTEM_PROMPT}]
            st.session_state.total_tokens = 0
            st.rerun()

        download_data = json.dumps(st.session_state.history, indent=2).encode("utf-8")
        st.download_button(
            "⬇️  Download conversation",
            data=download_data,
            file_name="luto_conversation.json",
            mime="application/json",
        )

        st.divider()
        st.caption("Quick asks:")
        if st.button("🍲 Rainy-day menu"):
            st.session_state._prefill = "Ano gagawin ko for a rainy Friday?"
            st.rerun()
        if st.button("💰 Sinigang profit"):
            st.session_state._prefill = "Magkano profit sa Sinigang?"
            st.rerun()
        if st.button("👥 Customer reply"):
            st.session_state._prefill = "Paano ba sasagutin kapag nagtanong ng discount?"
            st.rerun()

    # Main area
    st.title("Luto — Your Carinderia Assistant 🍲")
    st.caption("Menu planning, pricing, inventory advice, customer replies.")

    # Display history
    for msg in st.session_state.history:
        if msg["role"] != "system":
            with st.chat_message(msg["role"]):
                st.write(msg["content"])

    # Welcome message on first visit
    if len(st.session_state.history) == 1:
        with st.chat_message("assistant"):
            st.write("Kumusta! I'm Luto. Ask me anything about your carinderia — menu, prices, inventory, customer replies. Tagalog, English, or Taglish — all good!")

    # Chat input (with optional prefill from quick-ask buttons)
    prefill = st.session_state.pop("_prefill", None)
    user_input = st.chat_input("Ask Luto anything...") or prefill

    if user_input:
        st.session_state.history.append({"role": "user", "content": user_input})
        with st.chat_message("user"):
            st.write(user_input)

        with st.chat_message("assistant"):
            with st.spinner("Luto is thinking..."):
                try:
                    response = client.chat.completions.create(
                        model="gpt-3.5-turbo",
                        messages=st.session_state.history,
                    )
                    reply = response.choices[0].message.content
                except Exception as e:
                    reply = f"[Error] {e}"
            st.write(reply)

        st.session_state.history.append({"role": "assistant", "content": reply})
        # Rough token estimate
        st.session_state.total_tokens += len(user_input) // 4 + len(reply) // 4 + 50

except ImportError:
    # Not run under streamlit — show guidance
    print("=" * 55)
    print("  LUTO STREAMLIT APP")
    print("=" * 55)
    print("\nThis file is a Streamlit app. To run it:")
    print("   pip install streamlit openai")
    print("   streamlit run act_1.answer.py")
    print("\nIt opens at http://localhost:8501")
    print("\nTo deploy publicly:")
    print("   1. Push this file + `requirements.txt` to GitHub")
    print("   2. Go to https://share.streamlit.io")
    print("   3. Connect the repo, add OPENAI_API_KEY in Secrets")
    print("   4. Click Deploy — get a public URL")
    print("=" * 55)
