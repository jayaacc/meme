<template>
  <div class="flex flex-wrap gap-2">
    <a
      v-for="tag in tags"
      :key="tag.name"
      href="#"
      class="tag flex items-center space-x-1"
      @click.prevent
    >
      <span>{{ tag.name }}</span>
      <span class="text-xs opacity-60">{{ tag.count }}</span>
    </a>
  </div>
</template>

<script setup>
defineProps({
  tags: {
    type: Array,
    required: true
  }
})
</script>
