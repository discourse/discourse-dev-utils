import { apiInitializer } from "discourse/lib/api";
import DevToolboxHeaderIcon from "../components/dev-toolbox-header-icon";
import DevToolboxModal from "../components/modal/dev-toolbox-modal";

export default apiInitializer("1.28.0", (api) => {
  const currentUser = api.getCurrentUser();

  if (!currentUser?.admin) {
    return;
  }

  if (settings.show_header_button) {
    api.headerIcons.add("dev-toolbox", DevToolboxHeaderIcon, {
      before: "chat",
    });
  }

  const showDevToolbox = (event) => {
    const elementTagName = event.target?.tagName.toLowerCase();

    if (["input", "textarea", "select", "button"].includes(elementTagName)) {
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
