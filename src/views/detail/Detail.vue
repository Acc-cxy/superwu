<template>
    <div id="detail">
      <DetailNavbar class="datailnavbar" @titleclick="titleclick"/>
      <Scroll class="scroll-box" ref="scroll">
        <DetailSwiper
            :top-images="topImages"/>
        <DetailBaseInfo :goods="goods"/>
        <DetailShopInfo :shop="shop"/>
        <DetailGoodsInfo
            :detail-info="detailInfo"
             @imageLoad="imageLoad"/>
        <DetailParamInfo :paramInfo="goodsParam"/>
        <DetailCommentInfo  :commentInfo="commentInfo"/>
        <Goodlist :goods="recommend" />
      </Scroll>
      <backtop @click.native="backClick" v-show="isShowBackTop"/>
    </div>
</template>

<script>
import DetailNavbar from "./childComps/DetailNavbar";
import DetailSwiper from "./childComps/DetailSwiper";
import DetailBaseInfo from "./childComps/DetailBaseInfo";
import DetailShopInfo from "./childComps/DetailShopInfo";
import Scroll from "components/common/componets/Scroll";
import DetailGoodsInfo from "./childComps/DetailGoodsInfo";
import DetailParamInfo from "./childComps/DetailParamInfo";
import DetailCommentInfo from "./childComps/DetailCommentInfo";
import Goodlist from "components/content/goods/Goodlist";

import backtop from "components/content/backtop/backtop";

import {getdetail,Goods,Shop,GoodsParam,getrecommend} from "../../network/detail";
import {mixinorder} from "common/mixin"

export default {
  name: "Detail",
  components:{
    DetailNavbar,
    DetailSwiper,
    DetailBaseInfo,
    DetailShopInfo,
    DetailGoodsInfo,
    DetailParamInfo,
    DetailCommentInfo,
    Scroll,
    Goodlist,
    backtop
  },
  data() {
   return {
     iid:null,
     topImages:[],
     goods: {},
     shop: {},
     detailInfo: {},
     goodsParam:{},
     recommend:[],
     getup:null,
     commentInfo:{},
     isShowBackTop:true,
     themetops:[0,1000,2000,3000]
   }
 },
  mixins:[mixinorder],
  created() {
    // 获取详情页id
    this.iid = this.$route.params.iid
    // 获取详情页信息
    getdetail(this.iid).then(res=>{
      // console.log(res)
      const data = res.result;
      this.topImages = data.itemInfo.topImages
      //创建商品信息
      this.goods = new Goods(data.itemInfo, data.columns, data.shopInfo.services)

      //创建店铺信息
      this.shop = new Shop(data.shopInfo)

      //创建产品详情信息
      this.detailInfo = data.detailInfo

      //商品参数
      this.goodsParam = new GoodsParam(data.itemParams.info,data.itemParams.rule)

      //评论信息
      // if (data.rate.list) {
        this.commentInfo = data.rate.list[0];
      // }
    })

    // 获取推荐信息
    getrecommend().then(res=>{
      console.log(res)
      this.recommend = res.data.list
    })

  },
  methods: {
    imageLoad() {
      this.$refs.scroll.refresh()
    },
    backClick() {
      this.$refs.scroll.scrollTo(0, 0,3000)
    },
    contentScroll(position) {
      // console.log(position)
      //判断backtop是否显示
      this.isShowBackTop = (-position.y) > 1000
    },
    titleclick(index) {
      console.log(index)
      this.$refs.scroll.scrollTo(0,-this.themetops[index],500)
    }
  },
  updated() {
    this.themetops = []
  },
  destroyed() {
    this.$bus.$off('getup',this.getup)
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