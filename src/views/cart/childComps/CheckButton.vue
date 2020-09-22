<template>
  <div class="imagebox" :class="{buttonbox:checkout}" >
    <img src="~assets/img/cart/tick.svg" alt="">
  </div>
</template>

<script>
export default {
  name: "CheckButton",
  props:{
    checkout:{
      type:Boolean,
      default:false
    }
  },
  computed:{

  },
  methods:{
  }
}
</script>

<style scoped>
    .imagebox{
      width: 20px;
      height: 20px;
      border: 2px solid #999999;
      border-radius: 50%;
      display: inline-block;
    }

    .buttonbox{
      text-align: center;
      background: red;
      border: 0;
    }
    .buttonbox img{
      margin: 2px 0;
    }
</style>