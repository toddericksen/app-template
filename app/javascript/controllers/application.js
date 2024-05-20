import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Import and register all TailwindCSS Components or just the ones you need
import { Alert, Autosave, ColorPreview, Dropdown, Modal, Tabs, Popover, Toggle, Slideover } from "tailwindcss-stimulus-components"
application.register('alert', Alert)
application.register('autosave', Autosave)
application.register('color-preview', ColorPreview)
application.register('dropdown', Dropdown)
application.register('modal', Modal)
application.register('popover', Popover)
application.register('slideover', Slideover)
application.register('tabs', Tabs)
application.register('toggle', Toggle)


// import Flatpickr
import Flatpickr from 'stimulus-flatpickr'

// Manually register Flatpickr as a stimulus controller
application.register('flatpickr', Flatpickr)


// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }


