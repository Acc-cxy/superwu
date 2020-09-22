<template>
    <div class="bottom-bar">
        <div class="bar-content">
          <CheckButton></CheckButton>
          <span>全选</span>
          <div>
            {{totalprice}}
          </div>
        </div>
    </div>
</template>

<script>
import CheckButton from "@/views/cart/childComps/CheckButton";

export default {
  name: "CartBottonbar",
  data(){
    return{
      totalprice:0
    }
  },
  components:{
    CheckButton
  },
  computed:{
    // totalprice() {
    //   const cartList = this.$store.getters.cartlist;
    //   return cartList.filter(item => {
    //     return item.checked
    //   }).reduce((preValue, item) => {
    //     return preValue + item.count * item.price
    //   }, 0).toFixed(2)
    // }
    // totalprice() {
    //    return '￥' + this.$store.state.cartlist.filter(item =>{
    //      return item.checked
    //    }).reduce((preValue,item) =>{
    //      return item.price * item.count
    //    },0)
    // }
  }
}
</script>

<style scoped>
    .bottom-bar{
      width: 100%;
      height: 40px;
      background: red;
      position: fixed;
      bottom: 49px;
      box-sizing: border-box;
      box-shadow: 0 -2px 3px rgba(0, 0, 0, .2);
      background-color: #eee;
    }
    .bar-content{
      width: 70px;
      height: 40px;
      display: flex;
      justify-content: center;
      align-content: center;
    }
    .bottom-bar span{
      height: 20px;
    }
</style>