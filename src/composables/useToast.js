import { reactive } from 'vue'

const toastState = reactive({
  message: '',
  type: 'default',
  visible: false
})

let timer = null

export function useToast() {
  const show = (message, type = 'default') => {
    toastState.message = message
    toastState.type = type
    toastState.visible = true

    if (timer) clearTimeout(timer)
    timer = setTimeout(() => {
      toastState.visible = false
    }, 2000)
  }

  return {
    toastState,
    show
  }
}
