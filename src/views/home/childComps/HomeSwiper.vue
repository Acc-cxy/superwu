<template>
  <swiper>
    <!--eslint-disable-next-line-->
    <swiper-item v-for="item in banners" >
      <a :href="item.link">
        <img :src="item.image" alt="" @load="imgaeload">
      </a>
    </swiper-item>
  </swiper>
</template>

<script>
  import {Swiper, SwiperItem} from 'components/common/swiper'

  export default {
    name: "HomeSwiper",
    props: {
      banners: {
        type: Array,
        default() {
          return []
        }
      }
    },
    data() {
      return {
        isLoad:false
      }
    },
    components: {
      Swiper,
      SwiperItem
    },
    methods: {
      imgaeload() {
        if(!this.isLoad){
          this.$emit('imgaebox')
          this.isLoad = true
        }
      }
    }
  }
</script>

<style scoped>

</style>
