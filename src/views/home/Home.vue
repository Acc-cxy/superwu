<template>
  <div id="home">
    <nav-bar class="home-nav"><div slot="center">购物街</div></nav-bar>

    <scroll ref="scroll"
            class="scroll-box"
            :probe-type="3"
            @scroll="contentScroll"
            :pull-up-load="true">
            <home-swiper :banners="banners"/>
            <recommend-view :recommends="recommends"/>
            <feature/>
            <tab-control class="tab-control"
                         :titles="['流行', '新款', '精选']"
                         @tabClick="tabClick"/>
            <Goodlist :goods='showGoods'/>
    </scroll>

    <backtop @click.native="backClick" v-show="isShowBackTop"/>
  </div>
</template>

<script>
  import NavBar from 'components/common/navbar/NavBar'
  import HomeSwiper from './childComps/HomeSwiper'
  import RecommendView from './childComps/RecommendView'
  import TabControl from 'components/content/TabControl/TabControl'
  import feature from "./childComps/feature"
  import Goodlist from 'components/content/goods/Goodlist'
  import scroll from "components/common/componets/Scroll"
  import backtop from "components/content/backtop/backtop"
  import {getHomeMultidata,getHomeGoods} from 'network/home'
  export default {
    name: "Home",
    components: {
      NavBar,
      HomeSwiper,
      RecommendView,
      feature,
      TabControl,
      Goodlist,
      scroll,
      backtop
    },
    data() {
      return {
        banners: [],
        recommends: [],
        goods: {
          'pop': {page: 0, list: []},
          'new': {page: 0, list: []},
          'sell': {page: 0, list: []},
        },
        currentType: 'pop',
        isShowBackTop: false
      }
    },
    computed: {
      showGoods() {
        return this.goods[this.currentType].list
      },
    },
    created() {
      // 1.请求多个数据
      this.getHomeMultidata()

      this.getHomeGoods('pop')
      this.getHomeGoods('new')
      this.getHomeGoods('sell')

      // 监听图片加载完成
      this.$bus.$on('itemimgload',()=>{
        console.log(1)
        this.$refs.scroll.refresh()
      })
    },
    methods: {
      /**
       * 事件监听相关的方法
       */
      tabClick(index) {
        switch (index) {
          case 0:
            this.currentType = 'pop'
            break
          case 1:
            this.currentType = 'new'
            break
          case 2:
            this.currentType = 'sell'
            break
        }
      },
      // 新增
      backClick() {
        this.$refs.scroll.scrollTo(0, 0,3000)
      },
      contentScroll(position) {
        this.isShowBackTop = (-position.y) > 100
      },


      getHomeMultidata(){
        getHomeMultidata().then(res => {
          this.banners = res.data.banner.list;
          this.recommends = res.data.recommend.list;
        })
      },
      getHomeGoods(type){
        const page = this.goods[type].page + 1
        getHomeGoods(type , page).then(res => {
          this.goods[type].list.push(...res.data.list)
          this.goods[type].page +=1

        })
      }
    }
  }
</script>

<style scoped>
  #home{
    height: 100vh;
    position: relative;
  }
  .home-nav {
    background-color: var(--color-tint);
    color: #fff;
    width: 100%;
    z-index: 9;
  }
  .tab-control {
    z-index: 9;
  }

  .scroll-box{
    position: absolute;
    left: 0;
    right: 0;
    top: 44px;
    bottom: 49px;
    /*height: calc(100% - 93px);*/
    /*margin-top: 44px;*/
    overflow: hidden;
  }
</style>
