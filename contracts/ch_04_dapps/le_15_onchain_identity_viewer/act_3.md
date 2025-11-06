# Activity 3: ProfileUpdated Listener Test

**Time**: 10 minutes  
**Goal**: Write a test for `ProfileViewer` to ensure it re-fetches when `ProfileUpdated` fires for the current account.

## Background

Testing event listeners ensures your components react properly to blockchain events. This activity focuses on testing the ProfileUpdated event subscription and automatic data refresh functionality.

## Test Suite Structure

Create `__tests__/ProfileViewer.test.js`:

```javascript
import React from "react";
import { render, screen, waitFor } from "@testing-library/react";
import ProfileViewer from "../ProfileViewer";
import { ethers } from "ethers";

jest.mock("ethers");

describe("ProfileViewer Component", () => {
  const fakeProvider = {};
  const fakeContract = {
    getProfile: jest.fn(),
    getCredential: jest.fn(),
    on: jest.fn(),
    removeAllListeners: jest.fn(),
  };

  beforeAll(() => {
    global.window.ethereum = {
      request: jest.fn().mockResolvedValue(["0xABC"]),
    };
    ethers.providers.JsonRpcProvider = jest.fn().mockReturnValue(fakeProvider);
    ethers.Contract = jest.fn().mockReturnValue(fakeContract);
    // initial profile data
    fakeContract.getProfile.mockResolvedValue([
      "Alice",
      "Student",
      ethers.BigNumber.from("2"),
    ]);
    fakeContract.getCredential
      .mockResolvedValueOnce("NBI Clear")
      .mockResolvedValueOnce("PhilSys ID");
  });

  it("loads and displays profile", async () => {
    render(<ProfileViewer />);
    expect(await screen.findByText(/Name:/)).toHaveTextContent("Alice");
    expect(screen.getByText(/Status:/)).toHaveTextContent("Student");
    expect(screen.getByText("NBI Clear")).toBeInTheDocument();
    expect(screen.getByText("PhilSys ID")).toBeInTheDocument();
  });

  it("subscribes to ProfileUpdated event", async () => {
    render(<ProfileViewer />);
    await waitFor(() => {
      expect(fakeContract.on).toHaveBeenCalledWith(
        "ProfileUpdated",
        expect.any(Function)
      );
    });
  });
});
```

## To Do List

- [ ] Set up Jest mocks for ethers.js and window.ethereum
- [ ] Mock contract methods: `getProfile`, `getCredential`, `on`, `removeAllListeners`
- [ ] Test profile data rendering with expected content
- [ ] Verify ProfileUpdated event listener registration
- [ ] Ensure proper cleanup of event listeners on unmount

## Key Concepts

- **React Testing Library**: Testing React components with user-focused assertions
- **Jest Mocking**: Mocking external dependencies for isolated unit tests
- **Event Testing**: Verifying event subscription and callback registration
- **Async Testing**: Handling asynchronous data loading in tests

## Jest Configuration

Add to `jest.config.js`:

```javascript
module.exports = {
  testEnvironment: "jsdom",
  moduleNameMapper: { "\\.(css|scss)$": "identity-obj-proxy" },
};
```
