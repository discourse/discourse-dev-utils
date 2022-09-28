import Controller from "@ember/controller";
import { action } from "@ember/object";
import DiscourseURL from "discourse/lib/url";

export default class extends Controller {
  commonSettings = [
    { id: "branding", name: "branding" },
    { id: "categoryStyle", name: "category_style" },
    { id: "tagStyle", name: "tag_style" },
    { id: "topMenu", name: "top_menu" },
    { id: "desktopCategoryPageStyle", name: "desktop_category_page_style" },
    { id: "enableSidebar", name: "enable_sidebar" },
    { id: "enableSidebarHamburger", name: "enable_sidebar_hamburger" },
  ];

  @action
  visitThemes() {
    DiscourseURL.routeTo("/admin/customize/themes");
  }

  @action
  visitColors() {
    DiscourseURL.routeTo("/admin/customize/colors");
  }

  @action
  visitSettings() {
    DiscourseURL.routeTo("/admin/site_settings/");
  }

  @action
  visitPlugins() {
    DiscourseURL.routeTo("/admin/plugins/");
  }

  @action
  visitUserPrefs() {
    DiscourseURL.routeTo("/my/preferences/account");
  }

  @action
  visitTextCustomize() {
    DiscourseURL.routeTo("/admin/customize/site_texts?q=");
  }

  @action
  toggleAlerts() {
    if (document.body.classList.contains("alerts-hidden")) {
      document.body.classList.remove("alerts-hidden");
      localStorage.setItem("alerts-visibility", "alerts-visible");
    } else {
      document.body.classList.add("alerts-hidden");
      localStorage.setItem("alerts-visibility", "alerts-hidden");
    }
    this._triggerModalClose();
  }

  @action
  togglePluginOutlets() {
    if (document.body.classList.contains("plugin-outlets-visible")) {
      document.body.classList.remove("plugin-outlets-visible");
      localStorage.setItem("plugin-outlet-visibility", "outlets-invisible");
    } else {
      document.body.classList.add("plugin-outlets-visible");
      localStorage.setItem("plugin-outlet-visibility", "outlets-visible");
    }
    this._triggerModalClose();
  }

  @action
  navigateToSetting(setting) {
    const base = "/admin/site_settings/category";
    switch (setting) {
      case "tagStyle":
        DiscourseURL.routeTo(`${base}/all_results?filter=tag_style`);
        break;
      case "topMenu":
        DiscourseURL.routeTo(`${base}/all_results?filter=top_menu`);
        break;
      case "branding":
        DiscourseURL.routeTo(`${base}/branding`);
        break;
      case "categoryStyle":
        DiscourseURL.routeTo(`${base}/basic?filter=category_style`);
        break;
      case "desktopCategoryPageStyle":
        DiscourseURL.routeTo(
          `${base}/basic?filter=desktop_category_page_style`
        );
      case "enableSidebar":
        DiscourseURL.routeTo(`${base}/all_results?filter=enable_sidebar`);
      case "enableSidebarHamburger":
        DiscourseURL.routeTo(
          `${base}/all_results?filter=enable%20experimental%20sidebar%20hamburger`
        );
      default:
        break;
    }

    this.commonSetting = setting;
  }

  _triggerModalClose() {
    if (settings.actions_close_modal) {
      return this.send("closeModal");
    }
  }
}
