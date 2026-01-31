<template>
  <div class="meme-card group">
    <a href="javascript:;" @click.prevent="$emit('open', meme)" class="block relative overflow-hidden">
      <img
        :src="meme.image"
        :alt="meme.title"
        class="meme-card-image group-hover:scale-105 transition-transform duration-500 cursor-pointer"
        loading="lazy"
      />
    </a>

    <div class="p-4">
      <h3 class="font-medium text-[#1d1d1f] truncate">{{ meme.title }}</h3>
      <div class="mt-2 flex gap-1.5">
        <span v-for="tag in meme.tags.slice(0, 2)" :key="tag" class="text-xs text-[#86868b]">
          #{{ tag }}
        </span>
      </div>

      <!-- 操作按钮 -->
      <div class="flex gap-2 mt-3">
        <button
          @click="copyImage"
          class="flex-1 py-1.5 text-xs bg-[#f5f5f7] text-[#1d1d1f] rounded-lg hover:bg-[#e8e8ed] transition-colors"
        >
          Copy
        </button>
        <button
          @click="downloadImage"
          class="flex-1 py-1.5 text-xs bg-[#1d1d1f] text-white rounded-lg hover:bg-[#424245] transition-colors"
        >
          Save
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { useToast } from '../composables/useToast'

const props = defineProps({
  meme: {
    type: Object,
    required: true
  }
})

const { show } = useToast()

defineEmits(['open'])

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
