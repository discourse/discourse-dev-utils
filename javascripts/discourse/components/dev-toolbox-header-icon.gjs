import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";
import I18n from "I18n";
import DevToolboxModal from "./modal/dev-toolbox";

export default class DevToolboxHeaderIcon extends Component {
  @service modal;

  @action
  showModal() {
    this.modal.show(DevToolboxModal);
  }

  get title() {
    return I18n.t(themePrefix("dev_utils.toggle_btn"));
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
