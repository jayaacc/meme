<template>
  <div class="min-h-screen flex flex-col">
    <!-- 顶部导航栏 -->
    <header class="sticky top-0 z-50 bg-white/80 backdrop-blur-xl border-b border-gray-200/50">
      <div class="max-w-6xl mx-auto px-5">
        <div class="flex items-center justify-between h-14">
          <!-- Logo -->
          <router-link to="/" class="group">
            <img src="/logo.png" alt="MemeShare" class="h-9 object-contain transition-transform group-hover:scale-105">
          </router-link>

          <!-- 导航链接 -->
          <nav class="hidden md:flex items-center space-x-1">
            <button
              @click="showAbout = true"
              class="px-4 py-2 text-[#1d1d1f] text-sm font-medium rounded-full hover:bg-transparent transition-colors"
            >
              About
            </button>
          </nav>

          <!-- 移动端菜单按钮 -->
          <button @click="mobileMenuOpen = !mobileMenuOpen" class="md:hidden p-2 rounded-full hover:bg-[#f5f5f7] transition-colors">
            <svg class="w-5 h-5 text-[#1d1d1f]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path v-if="!mobileMenuOpen" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16"/>
              <path v-else stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12"/>
            </svg>
          </button>
        </div>
      </div>

      <!-- 移动端菜单 -->
      <div v-if="mobileMenuOpen" class="md:hidden bg-white border-t border-gray-200/50">
        <div class="px-5 py-3 space-y-1">
          <button
            @click="showAbout = true; mobileMenuOpen = false"
            class="w-full text-left px-4 py-2.5 text-[#1d1d1f] text-sm font-medium rounded-full hover:bg-transparent transition-colors"
          >
            About
          </button>
        </div>
      </div>
    </header>

    <!-- 主内容区 -->
    <main class="flex-1">
      <router-view v-slot="{ Component }">
        <transition name="fade" mode="out-in">
          <component :is="Component" />
        </transition>
      </router-view>
    </main>

    <!-- 底部 -->
    <footer class="bg-white border-t border-gray-200/50 py-10 mt-8">
      <div class="max-w-6xl mx-auto px-5">
        <div class="flex flex-col items-center justify-center space-y-4">
          <img src="/logo.png" alt="MemeShare" class="h-7 object-contain">
          <p class="text-[#86868b] text-sm">
            © 2026 MemeShare. Share the fun, spread the joy.
          </p>
        </div>
      </div>
    </footer>

    <!-- Toast 提示 -->
    <Toast />

    <!-- 关于弹窗 -->
    <Teleport to="body">
      <div v-if="showAbout" class="fixed inset-0 z-[100]" @click.self="showAbout = false">
        <div class="absolute inset-0 bg-black/50" @click="showAbout = false"></div>
        <div class="absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-full max-w-sm px-4">
          <div class="bg-white rounded-2xl overflow-hidden shadow-xl">
            <div class="p-5">
              <!-- 标题 -->
              <div class="text-center mb-4">
                <img src="/logo.png" alt="MemeShare" class="h-20 mx-auto object-contain">
              </div>

              <!-- 内容 -->
              <div class="space-y-3 text-xs text-[#86868b]">
                <p>MemeShare is a platform dedicated to sharing popular memes. We curate the most trending and entertaining memes from around the internet, making it easy for you to find and share with friends.</p>

                <div class="bg-[#f5f5f7] rounded-xl p-3">
                  <h3 class="font-medium text-[#1d1d1f] mb-2 text-xs">Features</h3>
                  <ul class="space-y-1">
                    <li class="flex items-center">
                      <span class="text-[#1d1d1f] mr-1.5">✓</span>
                      Huge meme collection, updated regularly
                    </li>
                    <li class="flex items-center">
                      <span class="text-[#1d1d1f] mr-1.5">✓</span>
                      Organized tags for easy browsing
                    </li>
                    <li class="flex items-center">
                      <span class="text-[#1d1d1f] mr-1.5">✓</span>
                      One-click copy, easy download
                    </li>
                    <li class="flex items-center">
                      <span class="text-[#1d1d1f] mr-1.5">✓</span>
                      Pure static site, lightning fast
                    </li>
                  </ul>
                </div>
              </div>

              <!-- 关闭按钮 -->
              <button
                @click="showAbout = false"
                class="w-full mt-4 py-2 text-sm bg-[#1d1d1f] text-white rounded-lg hover:bg-[#424245] transition-colors"
              >
                Got it
              </button>
            </div>

            <!-- 关闭图标 -->
            <button
              @click="showAbout = false"
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
  </div>
</template>

<script setup>
import { ref } from 'vue'
import Toast from './components/Toast.vue'

const mobileMenuOpen = ref(false)
const showAbout = ref(false)
</script>

<style scoped>
.fade-enter-active,
.fade-leave-active {
  transition: opacity 0.25s ease;
}

.fade-enter-from,
.fade-leave-to {
  opacity: 0;
}
</style>
