<template>
    <div id="detail">
      <DetailNavbar class="datailnavbar" @titleclick="titleclick" ref="nav"/>
      <Scroll class="scroll-box"
              ref="scroll"
              :probe-type="3"
              @scroll="contentScroll">
        <ul>
          <!--eslint-disable-next-line-->
          <li v-for="item in $store.state.cartlist">
            {{item}}
          </li>
        </ul>
        <DetailSwiper :top-images="topImages"/>
        <DetailBaseInfo :goods="goods"/>
        <DetailShopInfo :shop="shop"/>
        <DetailGoodsInfo
            :detail-info="detailInfo"
             @imageLoad="imageLoad"/>
        <DetailParamInfo ref="param" :paramInfo="goodsParam"/>
        <DetailCommentInfo ref="commen" :commentInfo="commentInfo"/>
        <Goodlist ref="good" :goods="recommend" />
      </Scroll>
      <backtop @click.native="backClick"
               v-show="isShowBackTop"
                />
      <Detailbottonbar @addjoin="addjoin"/>
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
import Detailbottonbar from "./childComps/Detailbottonbar";


import {getdetail,Goods,Shop,GoodsParam,getrecommend} from "../../network/detail";
import {mixinorder,backtops} from "common/mixin"
import {debounce} from "common/utils"

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
    Detailbottonbar,
    Scroll,
    Goodlist
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
     isShowBackTop:false,
     themetops:[],
     getthemetops:null,
     currentIndex: 0
   }
 },
  mixins:[mixinorder,backtops],
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
       if (data.rate.list) {
          this.commentInfo = data.rate.list[0];
       }
    })

    // 获取推荐信息
    getrecommend().then(res=>{
      // console.log(res)
      this.recommend = res.data.list
    })

    this.getthemetops = debounce(() =>{
      this.themetops = []
      this.themetops.push(0);
      this.themetops.push(this.$refs.param.$el.offsetTop)
      this.themetops.push(this.$refs.commen.$el.offsetTop)
      this.themetops.push(this.$refs.good.$el.offsetTop)
      this.themetops.push(Number.MAX_VALUE)
    },200)
  },
  methods: {
    imageLoad() {
      // this.newRefresh()
      this.$refs.scroll.refresh()

      this.getthemetops()
    },
    contentScroll(position) {
      //判断backtop是否显示
      this.isShowBackTop = (-position.y) > 1000

      //获取y值
      const positiony = -position.y
      let length = this.themetops.length
      for(let i = 0; i < length-1;i++){
        // if(this.currentIndex !==i && ((i < length - 1 && positiony >= this.themetops[i] && positiony <
        //     this.themetops[i+1]) || (i === length -1 && positiony >this.themetops[i]))) {
        //   this.currentIndex = i;
        //   this.$refs.nav.currentIndex= this.currentIndex
        // }
        if(this.currentIndex !==i && (positiony >= this.themetops[i] && positiony < this.themetops[i+1])){
          this.currentIndex = i;
          this.$refs.nav.currentIndex= this.currentIndex
        }
      }
    },
    titleclick(index) {
      this.$refs.scroll.scrollTo(0,-this.themetops[index],500)
    },
    addjoin(){
      const product = {};
      product.image = this.topImages[0];
      product.title = this.goods.title;
      product.desc = this.goods.desc;
      product.price = this.goods.oldPrice;
      product.iid = this.iid;
	    this.$store.commit('addjoinone',product)
      // 重构失败代码
      // this.$store.dispatch('addjoin',product)
    }
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
    overflow: hidden;
  }

  .datailnavbar{
    position: relative;
    z-index: 9;
    background: #ffffff;
  }

  .scroll-box{
    position: absolute;
    top: 44px;
    bottom: 49px;
    left: 0;
    right: 0;
  }


</style>