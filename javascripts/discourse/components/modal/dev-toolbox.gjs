import Component from "@glimmer/component";
import { tracked } from "@glimmer/tracking";
import { action } from "@ember/object";
import DButton from "discourse/components/d-button";
import DModal from "discourse/components/d-modal";
import dIcon from "discourse/helpers/d-icon";
import DiscourseURL from "discourse/lib/url";
import { i18n } from "discourse-i18n";
import ComboBox from "select-kit/components/combo-box";

const COMMON_SETTINGS = [
  { id: "branding", name: "branding", path: "branding" },
  {
    id: "categoryStyle",
    name: "category_style",
    path: "basic?filter=category_style",
  },
  { id: "tagStyle", name: "tag_style", path: "all_results?filter=tag_style" },
  { id: "topMenu", name: "top_menu", path: "all_results?filter=top_menu" },
  {
    id: "desktopCategoryPageStyle",
    name: "desktop_category_page_style",
    path: "basic?filter=desktop_category_page_style",
  },
  {
    id: "navigationMenu",
    name: "navigation_menu",
    path: "all_results?filter=navigation_menu",
  },
];

export default class DevToolboxModal extends Component {
  @tracked commonSetting;

  @action
  toggleAlerts() {
    const hidden = document.body.classList.contains("alerts-hidden");

    localStorage.setItem(
      "alerts-visibility",
      hidden ? "alerts-visible" : "alerts-hidden"
    );
    document.body.classList.toggle("alerts-hidden");
    this._triggerModalClose();
  }

  @action
  togglePluginOutlets() {
    const visible = document.body.classList.contains("plugin-outlets-visible");

    localStorage.setItem(
      "plugin-outlet-visibility",
      visible ? "outlets-invisible" : "outlets-visible"
    );
    document.body.classList.toggle("plugin-outlets-visible");
    this._triggerModalClose();
  }

  @action
  navigateToSetting(setting) {
    const base = "/admin/site_settings/category";
    const { path } = COMMON_SETTINGS.find((s) => s.id === setting);
    DiscourseURL.routeTo(`${base}/${path}`);
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
      <h3>{{dIcon "person-running"}}
        {{i18n (themePrefix "dev_utils.actions.title")}}</h3>
      <div class="modal-button-group">
        <DButton
          @icon="exclamation"
          @label={{themePrefix "dev_utils.actions.toggle_alerts"}}
          @action={{this.toggleAlerts}}
        />
        <DButton
          @icon="plug"
          @label={{themePrefix "dev_utils.actions.toggle_plugin_outlets"}}
          @action={{this.togglePluginOutlets}}
        />
      </div>

      <h3>{{dIcon "link"}} {{i18n (themePrefix "dev_utils.links.title")}}</h3>
      <div class="modal-button-group">
        <DButton
          @icon="paintbrush"
          @label={{themePrefix "dev_utils.links.themes"}}
          @href="/admin/customize/themes"
        />
        <DButton
          @icon="puzzle-piece"
          @label={{themePrefix "dev_utils.links.components"}}
          @href="/admin/customize/components"
        />
        <DButton
          @icon="palette"
          @label={{themePrefix "dev_utils.links.colors"}}
          @href="/admin/customize/colors"
        />
        <DButton
          @icon="wrench"
          @label={{themePrefix "dev_utils.links.settings"}}
          @href="/admin/site_settings"
        />
        <DButton
          @icon="plug"
          @label={{themePrefix "dev_utils.links.plugins"}}
          @href="/admin/plugins"
        />
        <DButton
          @icon="user-gear"
          @label={{themePrefix "dev_utils.links.user_prefs"}}
          @href="/my/preferences/account"
        />
        <DButton
          @icon="font"
          @label={{themePrefix "dev_utils.links.text"}}
          @href="/admin/customize/site_texts?q="
        />
        <DButton
          rel="noopener noreferrer"
          target="_blank"
          @icon="code"
          @label={{themePrefix "dev_utils.links.plugin_api"}}
          @href="https://github.dev/discourse/discourse/blob/main/app/assets/javascripts/discourse/app/lib/plugin-api.gjs#L1"
        />
        <DButton
          rel="noopener noreferrer"
          target="_blank"
          @icon="book-open"
          @label={{themePrefix "dev_utils.links.docs"}}
          @href="https://docs.discourse.org/"
        />
        <DButton
          rel="noopener noreferrer"
          target="_blank"
          @icon="magnifying-glass"
          @label={{themePrefix "dev_utils.links.meta"}}
          @href="https://meta.discourse.org/c/documentation/10"
        />
        {{#each settings.custom_links as |link|}}
          <DButton
            @icon={{link.icon}}
            @translatedLabel={{link.name}}
            @href={{link.link}}
          />
        {{/each}}

      </div>

      <h3>{{dIcon "screwdriver-wrench"}}
        {{i18n (themePrefix "dev_utils.common_settings.title")}}</h3>
      <div class="modal-button-group">
        <ComboBox
          @content={{COMMON_SETTINGS}}
          @value={{this.commonSetting}}
          @onChange={{this.navigateToSetting}}
        />
      </div>
    </DModal>
  </template>
}
