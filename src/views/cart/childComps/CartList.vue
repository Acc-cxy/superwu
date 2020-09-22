<template>
  <div class="cart-list">
    <scroll class="scroll-box"
            ref="scroll">
      <cart-listitem
          v-for="(item,index) in cartcount"
          v-bind:itemInfo="item"
          v-bind:key="index">
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
    this.$refs.scroll.refresh()
  },
  methods:{
  }
}
</script>

<style scoped>
    .scroll-box{
      position: absolute;
      left: 0;
      right: 0;
      top: 44px;
      bottom: 89px;
      overflow: hidden;
    }
</style>