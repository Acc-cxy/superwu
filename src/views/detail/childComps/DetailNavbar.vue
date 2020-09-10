<template>
  <NavBar>
    <div slot="left" class="back" @click="backclick">
      <img src="~assets/img/common/back.svg" alt="">
    </div>
    <div slot="center" class="center">
      <!--eslint-disable-next-line-->
      <div v-for="(item,index) in titles"
           v-bind:key="item"
           class="center-item"
           :class="{active : index === currentIndex}"
           @click="itemclick(index)">
        {{item}}
      </div>
    </div>
  </NavBar>
</template>

<script>
import NavBar from "components/common/navbar/NavBar";

export default {
  name: "DetailNavbar",
  components:{
    NavBar
  },
  data() {
    return {
      titles:['商品','参数','评论','推荐'],
      currentIndex:0
    }
  },
  methods:{
    itemclick(index) {
      this.currentIndex = index
    },
    backclick() {
      // this.$router.back()
      this.$router.go(-1)
    }
  }
}
</script>

<style scoped>
  .center{
    display: flex;
  }
  .center-item{
    flex: 1;
  }
  .active{
    color: coral;
  }
  .back img{
    margin-top: 10px;
  }
</style>