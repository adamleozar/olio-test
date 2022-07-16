// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import * as React from "react";
import * as ReactDOM from "react-dom";

const App = () => {
  return <div>App is working</div>;
};

document.addEventListener("DOMContentLoaded", () => {
  const rootEl = document.getElementById("root");
  ReactDOM.render(<App />, rootEl);
});
