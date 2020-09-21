<template>
  <div class="cart-list">
    <scroll class="scroll-box"
            ref="scroll">
      <cart-listitem
          v-for="(item,index) in cartcount"
          :itemInfo="item"
          :key="index">
      </cart-listitem>
    </scroll>
  </div>
</template>

<script>
    import {mapGetters} from 'vuex'
    import Scroll from "@/components/common/componets/Scroll";
    import CartListitem from "@/views/cart/childComps/CartListitem";

export default {
  name: "CartList",
  components: {CartListitem, Scroll},
  computed:{
    ...mapGetters(['cartcount'])
  },
  activated() {
    console.log(11)
    this.$refs.scroll.refresh()
  },
  methods:{
    // shopbox(){
    //   this.$refs.scroll.refresh()
    // }
  }
}
</script>

<style scoped>
    .scroll-box{
      position: absolute;
      left: 0;
      right: 0;
      top: 44px;
      bottom: 49px;
      overflow: hidden;
    }
</style>