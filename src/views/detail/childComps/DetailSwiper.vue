<template>
  <swiper class="swiper-box">
    <!--eslint-disable-next-line-->
    <swiper-item v-for="item in topImages" class="swiper-item">
        <img :src="item" alt="">
    </swiper-item>
  </swiper>
</template>

<script>
import {Swiper, SwiperItem} from 'components/common/swiper'
export default {
  name: "DetailSwiper",
  components: {
    Swiper,
    SwiperItem
  },
  props:{
    topImages:{
      type:Array,
      default() {
        return []
      }
    }
  }
}
</script>

<style scoped>
  .swiper-box{
    height: 300px;
    overflow: hidden;
  }

</style>