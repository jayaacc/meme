<template>
  <div class="max-w-6xl mx-auto px-5 py-5">
    <!-- 标签导航 -->
    <section class="mb-8 sticky top-14 bg-white/95 backdrop-blur-xl z-40 py-3 -mx-5 px-5 border-b border-gray-200/50">
      <div class="flex items-center space-x-2 overflow-x-auto pb-1 scrollbar-hide">
        <button
          v-for="tag in tagsWithMemes"
          :key="tag.name"
          class="flex-shrink-0 px-4 py-1.5 text-xs font-medium rounded-lg transition-colors"
          :class="activeTag === tag.name ? 'bg-[#1d1d1f] text-white' : 'bg-[#f5f5f7] text-[#1d1d1f] hover:bg-[#e8e8ed]'"
          @click="scrollToSection(tag.name)"
        >
          {{ tag.name }}
          <span class="ml-1 opacity-60">{{ tag.count }}</span>
        </button>
      </div>
    </section>

    <!-- 按分类展示 -->
    <section
      v-for="tag in tagsWithMemes"
      :key="tag.name"
      :id="`section-${tag.name}`"
      class="mb-14 scroll-mt-36"
    >
      <div class="flex items-center justify-between mb-4">
        <h2 class="text-base font-medium text-[#1d1d1f]">
          {{ tag.name }}
        </h2>
        <span class="text-xs text-[#515154]">{{ getMemesByTag(tag.name).length }}</span>
      </div>

      <div class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 gap-5">
        <MemeCard
          v-for="meme in getMemesByTag(tag.name)"
          :key="meme.id"
          :meme="meme"
          @open="openModal"
        />
      </div>
    </section>

    <!-- 弹窗 -->
    <MemeModal :meme="modalMeme" @close="closeModal" />
  </div>
</template>

<script setup>
import { ref, computed } from 'vue'
import memeData from '../data/memes.json'
import MemeCard from '../components/MemeCard.vue'
import MemeModal from '../components/MemeModal.vue'

const activeTag = ref('')
const modalMeme = ref(null)

const tagsWithMemes = computed(() => {
  return memeData.tags
    .filter(tag => memeData.memes.some(m => m.tags.includes(tag.name)))
    .sort((a, b) => b.count - a.count)
})

const getMemesByTag = (tagName) => {
  return memeData.memes.filter(m => m.tags.includes(tagName))
}

const scrollToSection = (tagName) => {
  activeTag.value = tagName
  const element = document.getElementById(`section-${tagName}`)
  if (element) {
    const headerOffset = 80
    const elementPosition = element.getBoundingClientRect().top
    const offsetPosition = elementPosition + window.pageYOffset - headerOffset
    window.scrollTo({ top: offsetPosition, behavior: 'smooth' })
  }
  setTimeout(() => { activeTag.value = '' }, 1500)
}

const openModal = (meme) => {
  modalMeme.value = meme
}

const closeModal = () => {
  modalMeme.value = null
}
</script>

<style scoped>
.scrollbar-hide {
  -ms-overflow-style: none;
  scrollbar-width: none;
}
.scrollbar-hide::-webkit-scrollbar {
  display: none;
}
</style>
