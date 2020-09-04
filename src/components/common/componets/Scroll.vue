<template>
  <div class="wrapper" ref="wrapper">
    <div class="content">
      <slot></slot>
    </div>
  </div>
</template>

<script>
  import BScroll from 'better-scroll'

  export default {
    name:"scroll",
    data() {
      return {
        scroll:null
      }
    },
    mounted() {
      this.scroll = new BScroll(this.$refs.wrapper, {
      // this.scroll = new BScroll (this.$refs.wrapper,{
      })
      this.scroll.scrollTo(0,0)
    }
  }
</script>

<style scoped>

</style>
