// Entry point for the build script in your package.json
import "@hotwired/turbo-rails";
import * as React from "react";
import * as ReactDOM from "react-dom";
import Home from './components/Home/Home';

const App = () => {
  return <Home />;
};

document.addEventListener("DOMContentLoaded", () => {
  const rootEl = document.getElementById("root");
  ReactDOM.render(<App />, rootEl);
});
