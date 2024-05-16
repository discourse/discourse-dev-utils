import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";
import DModal from "discourse/components/d-modal";
import DiscourseURL from "discourse/lib/url";
import dIcon from "discourse-common/helpers/d-icon";
import i18n from "discourse-common/helpers/i18n";
import ComboBox from "select-kit/components/combo-box";

export default class DevToolboxModal extends Component {
  @tracked commonSetting;
  commonSettings = [
    { id: "branding", name: "branding" },
    { id: "categoryStyle", name: "category_style" },
    { id: "tagStyle", name: "tag_style" },
    { id: "topMenu", name: "top_menu" },
    { id: "desktopCategoryPageStyle", name: "desktop_category_page_style" },
    { id: "navigationMenu", name: "navigation_menu" },
  ];

  @action
  visitThemes() {
    DiscourseURL.routeTo("/admin/customize/themes");
  }

  @action
  visitComponents() {
    DiscourseURL.routeTo("/admin/customize/components");
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
        break;
      case "navigationMenu":
        DiscourseURL.routeTo(`${base}/all_results?filter=navigation_menu`);
        break;
    }

    this.commonSetting = setting;
  }

  _triggerModalClose() {
    if (settings.actions_close_modal) {
      this.args.closeModal();
    }
  }

  <template>
    <DModal
      @closeModal={{@closeModal}}
      @title={{i18n (themePrefix "dev_utils.modal.title")}}
      class="dev-toolbox-modal"
    >
      <h3>{{dIcon "running"}}
        {{i18n (themePrefix "dev_utils.actions.title")}}</h3>
      <div class="modal-button-group">
        <DButton
          @title={{themePrefix "dev_utils.actions.toggle_alerts"}}
          @icon="exclamation"
          @label={{themePrefix "dev_utils.actions.toggle_alerts"}}
          @action={{this.toggleAlerts}}
        />
        <DButton
          @title={{themePrefix "dev_utils.actions.toggle_plugin_outlets"}}
          @icon="plug"
          @label={{themePrefix "dev_utils.actions.toggle_plugin_outlets"}}
          @action={{this.togglePluginOutlets}}
        />
      </div>

      <h3>{{dIcon "link"}} {{i18n (themePrefix "dev_utils.links.title")}}</h3>
      <div class="modal-button-group">
        <DButton
          @title={{themePrefix "dev_utils.links.themes"}}
          @icon="paint-brush"
          @label={{themePrefix "dev_utils.links.themes"}}
          @action={{this.visitThemes}}
        />
        <DButton
          @title={{themePrefix "dev_utils.links.components"}}
          @icon="puzzle-piece"
          @label={{themePrefix "dev_utils.links.components"}}
          @action={{this.visitComponents}}
        />
        <DButton
          @title={{themePrefix "dev_utils.links.colors"}}
          @icon="palette"
          @label={{themePrefix "dev_utils.links.colors"}}
          @action={{this.visitColors}}
        />
        <DButton
          @title={{themePrefix "dev_utils.links.settings"}}
          @icon="wrench"
          @label={{themePrefix "dev_utils.links.settings"}}
          @action={{this.visitSettings}}
        />
        <DButton
          @title={{themePrefix "dev_utils.links.plugins"}}
          @icon="plug"
          @label={{themePrefix "dev_utils.links.plugins"}}
          @action={{this.visitPlugins}}
        />
        <DButton
          @title={{themePrefix "dev_utils.links.user_prefs"}}
          @icon="user-cog"
          @label={{themePrefix "dev_utils.links.user_prefs"}}
          @action={{this.visitUserPrefs}}
        />
        <DButton
          @title={{themePrefix "dev_utils.links.text"}}
          @icon="font"
          @label={{themePrefix "dev_utils.links.text"}}
          @action={{this.visitTextCustomize}}
        />
        <a
          target="_blank"
          rel="noopener noreferrer"
          href="https://github.dev/discourse/discourse/blob/main/app/assets/javascripts/discourse/app/lib/plugin-api.gjs#L1"
          class="btn btn-icon-text"
        >
          {{dIcon "code"}}
          {{i18n (themePrefix "dev_utils.links.plugin_api")}}
        </a>
        <a
          target="_blank"
          rel="noopener noreferrer"
          href="https://docs.discourse.org/"
          class="btn btn-icon-text"
        >
          {{dIcon "book-open"}}
          {{i18n (themePrefix "dev_utils.links.docs")}}
        </a>
        {{#each settings.custom_links as |link|}}
          <a href={{link.link}} class="btn btn-icon-text">{{dIcon link.icon}}
            {{link.name}}</a>
        {{/each}}

      </div>

      <h3>{{dIcon "tools"}}
        {{i18n (themePrefix "dev_utils.common_settings.title")}}</h3>
      <div class="modal-button-group">
        <ComboBox
          @content={{this.commonSettings}}
          @value={{this.commonSetting}}
          @onChange={{this.navigateToSetting}}
        />
      </div>
    </DModal>
  </template>
}
