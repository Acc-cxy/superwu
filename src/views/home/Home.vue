<template>
  <div id="home">
    <nav-bar class="home-nav"><div slot="center">购物街</div></nav-bar>
    <tab-control :titles="['流行', '新款', '精选']"
                 @tabClick="tabClick"
                 ref="tabControl1"
                 class="tab-control"
                 v-show="isfixed"/>
    <scroll ref="scroll"
            class="scroll-box"
            :probe-type="3"
            @scroll="contentScroll"
            :pull-up-load="true"
            @pullingUp="imgaeLoad">
            <home-swiper :banners="banners"
                         @imgaebox="imgaebox"/>
            <recommend-view :recommends="recommends"/>
            <feature/>
            <tab-control :titles="['流行', '新款', '精选']"
                         @tabClick="tabClick"
                         ref="tabControl2"/>
            <Goodlist :goods='showGoods'/>
    </scroll>

    <backtop @click.native="backClick" v-show="isShowBackTop"/>
  </div>
</template>

<script>
  import NavBar from 'components/common/navbar/NavBar'
  import HomeSwiper from './childComps/HomeSwiper'
  import RecommendView from './childComps/RecommendView'
  import feature from "./childComps/feature"
  import TabControl from 'components/content/TabControl/TabControl'
  import Goodlist from 'components/content/goods/Goodlist'
  import scroll from "components/common/componets/Scroll"
  import backtop from "components/content/backtop/backtop"
  import {getHomeMultidata,getHomeGoods} from 'network/home'
  import {debounce} from "common/utils"

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
        isShowBackTop: false,
        tabOffsetTop:0,
        isfixed:false,
        saveY:0,
        getup:null
      }
    },
    computed: {
      showGoods() {
        return this.goods[this.currentType].list
      },
    },
    destroyed() {
      console.log('home-destroyed')
    },
    activated() {
      this.$refs.scroll.scrollTo(0,this.saveY,0)
      this.$refs.scroll.refresh()
    },
    deactivated() {
      this.saveY = this.$refs.scroll.getsaveY()
      // console.log(this.saveY)

      // 取消全局监听
      this.$bus.$off('getup',this.getup)
    },
    created() {
      // 1.请求多个数据
      this.getHomeMultidata()

      this.getHomeGoods('pop')
      this.getHomeGoods('new')
      this.getHomeGoods('sell')
    },
    mounted() {
      // 监听图片加载完成
      const refresh = debounce(this.$refs.scroll.refresh,30)

      this.getup=()=>{
        refresh()
      }

      this.$bus.$on('itemimgload',this.getup)
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
        this.$refs.tabControl1.currentIndex = index;
        this.$refs.tabControl2.currentIndex = index;
      },
      // 新增
      backClick() {
        this.$refs.scroll.scrollTo(0, 0,3000)
      },
      //监听滑动位置
      contentScroll(position) {
        //判断backtop是否显示
        this.isShowBackTop = (-position.y) > 1000

        //决定tab是否吸顶
        this.isfixed = (-position.y) > this.tabOffsetTop
      },
      //  图片加载
      imgaeLoad() {
        this.getHomeGoods(this.currentType)
      },
      //吸顶settop
      imgaebox(){
        this.tabOffsetTop = this.$refs.tabControl2.$el.offsetTop
      },

      getHomeMultidata(){
        getHomeMultidata().then(res => {
          this.banners = res.data.banner.list;
          console.log(this.banners)
          this.recommends = res.data.recommend.list;
        })
      },
      getHomeGoods(type){
        const page = this.goods[type].page + 1
        getHomeGoods(type , page).then(res => {
          this.goods[type].list.push(...res.data.list)
          this.goods[type].page +=1

          this.$refs.scroll.finishPullUp()
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

  .tab-control{
    position: relative;
    z-index: 9;
  }
</style>
