<template>
  <Teleport to="body">
    <Transition name="toast">
      <div v-if="toastState.visible" class="fixed top-8 left-1/2 -translate-x-1/2 z-[200]">
        <div
          class="px-4 py-2 rounded-lg shadow-lg text-white text-xs font-medium"
          :class="toastState.type === 'success' ? 'bg-[#34c759]' : 'bg-[#1d1d1f]'"
        >
          {{ toastState.message }}
        </div>
      </div>
    </Transition>
  </Teleport>
</template>

<script setup>
import { useToast } from '../composables/useToast'

const { toastState } = useToast()
</script>

<style scoped>
.toast-enter-active,
.toast-leave-active {
  transition: all 0.3s ease;
}

.toast-enter-from,
.toast-leave-to {
  opacity: 0;
  transform: translateX(-50%) translateY(-20px);
}
</style>
