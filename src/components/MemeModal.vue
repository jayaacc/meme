<template>
  <Teleport to="body">
    <div v-if="meme" class="fixed inset-0 z-[100]" @click.self="close">
      <div class="absolute inset-0 bg-black/50" @click="close"></div>
      <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-sm px-4">
        <div class="bg-white rounded-2xl overflow-hidden shadow-xl">
          <div class="bg-[#f5f5f7] flex items-center justify-center">
            <img
              :src="meme.image"
              :alt="meme.title"
              class="w-full h-auto object-contain max-h-[50vh]"
            />
          </div>
          <div class="p-4">
            <h3 class="font-medium text-[#1d1d1f] truncate">{{ meme.title }}</h3>
            <div class="mt-2 flex gap-1.5">
              <span v-for="tag in meme.tags" :key="tag" class="text-xs text-[#86868b]">
                #{{ tag }}
              </span>
            </div>
            <p class="mt-3 text-sm text-[#86868b] line-clamp-2">{{ meme.description }}</p>
            <div class="flex gap-2 mt-4">
              <button
                @click="copyImage"
                class="flex-1 py-2 text-sm bg-[#f5f5f7] text-[#1d1d1f] rounded-lg hover:bg-[#e8e8ed] transition-colors"
              >
                Copy Link
              </button>
              <button
                @click="downloadImage"
                class="flex-1 py-2 text-sm bg-[#1d1d1f] text-white rounded-lg hover:bg-[#424245] transition-colors"
              >
                Save Image
              </button>
            </div>
          </div>
          <button
            @click="close"
            class="absolute top-3 right-7 w-7 h-7 bg-black/50 text-white rounded-full flex items-center justify-center hover:bg-black/70"
          >
            <svg class="w-4 h-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>
        </div>
      </div>
    </div>
  </Teleport>
</template>

<script setup>
import { useToast } from '../composables/useToast'

const props = defineProps({
  meme: {
    type: Object,
    default: null
  }
})

const { show } = useToast()

const emit = defineEmits(['close'])

const close = () => {
  emit('close')
}

const copyImage = async () => {
  try {
    await navigator.clipboard.writeText(props.meme.image)
    show('Link copied', 'success')
  } catch (err) {
    console.error('Copy failed:', err)
  }
}

const downloadImage = () => {
  const link = document.createElement('a')
  link.href = props.meme.image
  link.download = `${props.meme.title}.jpg`
  link.target = '_blank'
  link.click()
  show('Download started', 'success')
}
</script>
