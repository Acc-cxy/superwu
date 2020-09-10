<template>
    <div id="detail">
      <DetailNavbar class="datailnavbar"/>
      <Scroll class="scroll-box">
        <DetailSwiper
            :top-images="topImages"/>
        <DetailBaseInfo :goods="goods"/>
        <DetailShopInfo :shop="shop"/>
      </Scroll>
    </div>
</template>

<script>
import DetailNavbar from "./childComps/DetailNavbar";
import DetailSwiper from "./childComps/DetailSwiper";
import DetailBaseInfo from "./childComps/DetailBaseInfo";
import DetailShopInfo from "./childComps/DetailShopInfo";
import Scroll from "components/common/componets/Scroll";

import {getdetail,Goods,Shop} from "../../network/detail";

export default {
  name: "Detail",
  components:{
    DetailNavbar,
    DetailSwiper,
    DetailBaseInfo,
    DetailShopInfo,
    Scroll
  },
  data() {
   return {
     iid:null,
     topImages:[],
     goods: {},
     shop: {}
   }
 },
  created() {
   this.iid = this.$route.params.iid
    getdetail(this.iid).then(res=>{
      console.log(res)
      const data = res.result;
      this.topImages = data.itemInfo.topImages
      //创建商品信息
      this.goods = new Goods(data.itemInfo, data.columns, data.shopInfo.services)

      //创建店铺信息
      this.shop = new Shop(data.shopInfo)
    })

  }
}
</script>

<style scoped>
  #detail{
    position: relative;
    z-index: 999;
    background: #ffffff;
    height: 100vh;
  }

  .datailnavbar{
    position: relative;
    z-index: 9;
    background: #ffffff;
  }

  .scroll-box{
    height: calc(100% - 44px);
  }


</style>