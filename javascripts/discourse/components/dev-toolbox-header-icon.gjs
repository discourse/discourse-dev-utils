import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import { i18n } from "discourse-i18n";
import DevToolboxModal from "./modal/dev-toolbox";

export default class DevToolboxHeaderIcon extends Component {
  @service modal;

  @action
  showModal() {
    this.modal.show(DevToolboxModal);
  }

  get title() {
    return i18n(themePrefix("dev_utils.toggle_btn"));
  }

  <template>
    <DButton
      @action={{this.showModal}}
      @icon="gear"
      @translatedTitle={{this.title}}
      class="btn-flat icon dev-toolbox-trigger"
    />
  </template>
}
