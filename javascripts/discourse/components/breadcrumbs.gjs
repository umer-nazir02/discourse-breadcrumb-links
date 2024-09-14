import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { service } from "@ember/service";
import Category from "discourse/models/category";
import dIcon from "discourse-common/helpers/d-icon";
import i18n from "discourse-common/helpers/i18n";

export default class Breadcrumbs extends Component {
  @service router;
  @service site;
  @service discovery;
  @tracked routeType;
  @tracked category = null;

  get currentPage() {
    switch (true) {
      case this.router.currentRouteName.includes("userPrivateMessages"):
        return i18n("js.groups.messages");
      case this.router.currentRouteName.startsWith("admin"):
        return i18n("js.admin_title");
      case this.router.currentRouteName.startsWith("chat"):
        return i18n("js.chat.heading");
      case this.router.currentRouteName === "userNotifications.responses" ||
        this.router.currentRouteName === "userNotifications.mentions":
        return i18n("js.groups.mentions");
      case this.router.currentRouteName === "userActivity.bookmarks":
        return i18n("js.user.bookmarks");
      case this.router?.currentRoute?.parent?.name === "docs":
        return i18n("js.docs.title");
      case this.router?.currentRoute?.parent?.name === "preferences":
        return i18n("js.user.preferences.title");
      case this.router.currentRouteName.includes("discovery.category"):
        return this.categoryName;
      default:
        return null;
    }
  }

  get categorySlugPathWithID() {
    return this.router?.currentRoute?.params?.category_slug_path_with_id;
  }

  get categoryName() {
    if (this.categorySlugPathWithID) {
      return Category.findBySlugPathWithID(this.categorySlugPathWithID).name;
    }
  }

  <template>
    {{#if this.currentPage}}
      <div class="breadcrumbs">
        <div class="breadcrumbs__container">
          <span class="breadcrumbs__title">
            You are here
            {{dIcon "arrow-right"}}
          </span>
          <ul class="breadcrumbs__links">
            <li class="home">
              <a href="/">Home</a>
            </li>
            <li class="current">
              {{this.currentPage}}
            </li>
          </ul>
        </div>
      </div>
    {{/if}}
  </template>
}
