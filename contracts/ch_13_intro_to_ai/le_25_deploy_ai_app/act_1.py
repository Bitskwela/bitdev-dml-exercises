# app.py
# ============================================
# LUTO — Streamlit Web App (Deployment)
# by: <Your Name>
# ============================================
#
# !!! RUN LOCALLY — NOT IN THE IN-BROWSER SANDBOX !!!
# Streamlit needs a real Python environment and a browser.
# The sandbox cannot host a Streamlit server, so this file is
# read-along until you copy it to your own machine.
#
# Local setup:
#   pip install streamlit openai python-dotenv
#   streamlit run act_1.py
#
# `import streamlit` will fail in any environment without Streamlit
# installed (including the sandbox). That is expected.
#
# NOTE: This file is intentionally outlined.
# See act_1.answer.py for a fully-working Streamlit app.

# TODO: Imports
# import streamlit as st
# import os
# from openai import OpenAI   # or MockOpenAI fallback


# TODO: Page config
# st.set_page_config(page_title="Luto", page_icon="🍲", layout="centered")


# TODO: Session state setup
# if "history" not in st.session_state:
#     st.session_state.history = [{"role": "system", "content": SYSTEM_PROMPT}]
# if "total_tokens" not in st.session_state:
#     st.session_state.total_tokens = 0


# TODO: Sidebar
# with st.sidebar:
#     st.title("Luto 🍲")
#     st.caption("Your AI carinderia assistant")
#     st.metric("Messages", len([m for m in st.session_state.history if m["role"] != "system"]))
#     st.metric("Tokens", st.session_state.total_tokens)
#     if st.button("Clear chat"):
#         st.session_state.history = [{"role": "system", "content": SYSTEM_PROMPT}]
#         st.rerun()
#     # Download button for conversation JSON


# TODO: Main chat area
# st.title("Luto — Your Carinderia Assistant")
# for msg in st.session_state.history:
#     if msg["role"] != "system":
#         with st.chat_message(msg["role"]):
#             st.write(msg["content"])
#
# user_input = st.chat_input("Ask Luto anything...")
# if user_input:
#     st.session_state.history.append({"role": "user", "content": user_input})
#     with st.chat_message("user"):
#         st.write(user_input)
#     with st.chat_message("assistant"):
#         with st.spinner("Luto is thinking..."):
#             reply = chat_via_api(st.session_state.history)
#         st.write(reply)
#     st.session_state.history.append({"role": "assistant", "content": reply})
