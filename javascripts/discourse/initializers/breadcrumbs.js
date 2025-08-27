import { apiInitializer } from "discourse/lib/api";
// import Breadcrumbs from "../components/breadcrumbs";

export default apiInitializer("1.14.0", (api) => {
  api.decorateWidget("header:after", (decoratorHelper) => {
    // Check if the header-title element exists before trying to mount
    if (decoratorHelper.element.querySelector(".header-title")) {
      return decoratorHelper.attach("breadcrumbs");
    }
  });
});