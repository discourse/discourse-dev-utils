import { apiInitializer } from "discourse/lib/api";
import DevToolboxModal from "../components/modal/dev-toolbox-modal";

export default apiInitializer("0.11.1", (api) => {
  const currentUser = api.getCurrentUser();

  if (!currentUser?.admin) {
    return;
  }

  if (settings.show_header_button) {
    api.decorateWidget("header-icons:before", (helper) => {
      return helper.attach("header-dropdown", {
        title: themePrefix("dev_utils.toggle_btn"),
        icon: "cog",
        action: "toggleDevToolbox",
      });
    });

    api.attachWidgetAction("header", "toggleDevToolbox", function () {
      api.container.lookup("service:modal").show(DevToolboxModal);
    });
  }
  const isInputSelection = (el) => {
    const inputs = ["input", "textarea", "select", "button"];
    const elementTagName = el?.tagName.toLowerCase();

    if (inputs.includes(elementTagName)) {
      return false;
    }
    return true;
  };

  const showDevToolbox = (event) => {
    if (!isInputSelection(event.target)) {
      return;
    }
    api.container.lookup("service:modal").show(DevToolboxModal);
    event.preventDefault();
    event.stopPropagation();
  };

  api.addKeyboardShortcut("`", (event) => showDevToolbox(event), {
    global: true,
    help: {
      category: "application",
      name: "Open Dev Toolbox",
      definition: {
        keys1: ["`"],
      },
    },
  });

  api.onPageChange(() => {
    const alertsVisibilty = localStorage.getItem("alerts-visibility");

    if (alertsVisibilty === null) {
      localStorage.setItem("alerts-visibility", "alerts-visible");
    } else if (alertsVisibilty === "alerts-visible") {
      document.body.classList.remove("alerts-hidden");
    } else if (alertsVisibilty === "alerts-hidden") {
      document.body.classList.add("alerts-hidden");
    }
  });
});
