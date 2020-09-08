<template>
  <div class="back-top">
    <img src="~assets/img/common/top.png" alt="#">
  </div>
</template>

<script>
export default {
  name: "backtop"
}
</script>

<style scoped>
  .back-top{
    position: fixed;
    bottom: 49px;
    right: 0;
    z-index: 99;
    width: 50px;
    height: 50px;
  }
  .back-top img{
    width: 100%;
    height: 50px;
    border-radius: 50%;
  }
</style>