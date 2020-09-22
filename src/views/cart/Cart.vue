<template>
  <div class="cart">
    <!--  导航  -->
    <NavBar class="cart-nav">
      <div slot="center">购物车({{cartlength}})</div>
    </NavBar>
    <!--  商品列表  -->
    <CartList></CartList>

    <!--  买单区  -->
    <cart-bottonbar/>
  </div>
</template>

<script>
  import NavBar from "@/components/common/navbar/NavBar";
  import CartList from "@/views/cart/childComps/CartList";
  import CartBottonbar from "@/views/cart/childComps/CartBottonbar";
  import {mapGetters} from 'vuex'
  export default {
    name: "Cart",
    components:{
      CartList,
      NavBar,
      CartBottonbar
    },
    computed:{
      ...mapGetters(["cartlength"])
    }
  }
</script>

<style scoped>
  .cart{
    height: 100vh;
    position: relative;
  }

  .cart-nav{
    background: var(--color-tint);
    color: #ffffff;
    font-weight: 600;
  }
</style>
