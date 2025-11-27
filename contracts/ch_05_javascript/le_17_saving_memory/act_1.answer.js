// Task 1: Save and Load Theme Preference
function saveTheme(theme) {
  localStorage.setItem("app-theme", theme);
}

function loadTheme() {
  const savedTheme = localStorage.getItem("app-theme");

  if (savedTheme === "dark") {
    return "dark";
  } else {
    return "light";
  }
}

// Task 2: Save and Load Array Data
function saveScores(scores) {
  localStorage.setItem("app-scores", JSON.stringify(scores));
}

function loadScores() {
  const raw = localStorage.getItem("app-scores");

  if (!raw) {
    return [];
  }

  try {
    const parsed = JSON.parse(raw);
    if (Array.isArray(parsed)) {
      return parsed;
    } else {
      return [];
    }
  } catch (error) {
    return [];
  }
}

// Task 3: Clear Specific Data
function clearUserData(key) {
  const exists = localStorage.getItem(key) !== null;

  if (exists) {
    localStorage.removeItem(key);
    return true;
  }

  return false;
}
