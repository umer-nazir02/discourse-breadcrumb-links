import { apiInitializer } from "discourse/lib/api";
import BreadCrumbs from "../components/breadcrumbs";

export default apiInitializer("1.14.0", (api) => {
  api.renderInOutlet("above-main-container", BreadCrumbs);
  api.renderInOutlet("below-topic-title", BreadCrumbs);
});
