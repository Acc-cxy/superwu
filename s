warning: LF will be replaced by CRLF in package-lock.json.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in package.json.
The file will have its original line endings in your working directory
warning: LF will be replaced by CRLF in src/main.js.
The file will have its original line endings in your working directory
[1mdiff --git a/package-lock.json b/package-lock.json[m
[1mindex b665fdd..9762f63 100644[m
[1m--- a/package-lock.json[m
[1m+++ b/package-lock.json[m
[36m@@ -11016,6 +11016,11 @@[m
       "integrity": "sha1-HuO8mhbsv1EYvjNLsV+cRvgvWCU=",[m
       "dev": true[m
     },[m
[32m+[m[32m    "vuex": {[m
[32m+[m[32m      "version": "3.5.1",[m
[32m+[m[32m      "resolved": "https://registry.npmjs.org/vuex/-/vuex-3.5.1.tgz",[m
[32m+[m[32m      "integrity": "sha512-w7oJzmHQs0FM9LXodfskhw9wgKBiaB+totOdb8sNzbTB2KDCEEwEs29NzBZFh/lmEK1t5tDmM1vtsO7ubG1DFw=="[m
[32m+[m[32m    },[m
     "watchpack": {[m
       "version": "1.7.4",[m
       "resolved": "https://registry.npm.taobao.org/watchpack/download/watchpack-1.7.4.tgz",[m
[1mdiff --git a/package.json b/package.json[m
[1mindex da6a0d6..a519f18 100644[m
[1m--- a/package.json[m
[1m+++ b/package.json[m
[36m@@ -12,7 +12,8 @@[m
     "better-scroll": "^2.0.2",[m
     "core-js": "^3.6.5",[m
     "vue": "^2.6.11",[m
[31m-    "vue-router": "^3.4.3"[m
[32m+[m[32m    "vue-router": "^3.4.3",[m
[32m+[m[32m    "vuex": "^3.5.1"[m
   },[m
   "devDependencies": {[m
     "@vue/cli-plugin-babel": "~4.5.0",[m
[1mdiff --git a/src/common/mixin.js b/src/common/mixin.js[m
[1mindex 9462717..a51db3b 100644[m
[1m--- a/src/common/mixin.js[m
[1m+++ b/src/common/mixin.js[m
[36m@@ -1,4 +1,5 @@[m
 import {debounce} from "./utils";[m
[32m+[m[32mimport backtop from "@/components/content/backtop/backtop";[m
 [m
 export const mixinorder ={[m
     mounted() {[m
[36m@@ -8,4 +9,20 @@[m [mexport const mixinorder ={[m
         }[m
         this.$bus.$on('itemimgload',this.getup)[m
     }[m
[32m+[m[32m}[m
[32m+[m
[32m+[m[32mexport const backtops ={[m
[32m+[m[32m    components:{[m
[32m+[m[32m      backtop[m
[32m+[m[32m    },[m
[32m+[m[32m    data(){[m
[32m+[m[32m        return{[m
[32m+[m[32m            isShowBackTop: false[m
[32m+[m[32m        }[m
[32m+[m[32m    },[m
[32m+[m[32m    methods:{[m
[32m+[m[32m        backClick() {[m
[32m+[m[32m             this.$refs.scroll.scrollTo(0, 0,300)[m
[32m+[m[32m        }[m
[32m+[m[32m    }[m
 }[m
\ No newline at end of file[m
[1mdiff --git a/src/main.js b/src/main.js[m
[1mindex 99bb653..24d4220 100644[m
[1m--- a/src/main.js[m
[1m+++ b/src/main.js[m
[36m@@ -1,6 +1,7 @@[m
 import Vue from 'vue'[m
 import App from './App.vue'[m
 import router from './router'[m
[32m+[m[32mimport store from "./store";[m
 [m
 Vue.config.productionTip = false[m
 [m
[36m@@ -8,5 +9,6 @@[m [mVue.prototype.$bus =new Vue()[m
 [m
 new Vue({[m
   render: h => h(App),[m
[31m-  router[m
[32m+[m[32m  router,[m
[32m+[m[32m  store[m
 }).$mount('#app')[m
[1mdiff --git a/src/views/detail/Detail.vue b/src/views/detail/Detail.vue[m
[1mindex 2287b04..63c9cab 100644[m
[1m--- a/src/views/detail/Detail.vue[m
[1m+++ b/src/views/detail/Detail.vue[m
[36m@@ -5,6 +5,13 @@[m
               ref="scroll"[m
               :probe-type="3"[m
               @scroll="contentScroll">[m
[32m+[m[32m        <ul>[m
[32m+[m[32m          <!--eslint-disable-next-line-->[m
[32m+[m[32m          <li v-for="item in $store.state.cartlist">[m
[32m+[m[32m            {{item}}[m
[32m+[m[32m          </li>[m
[32m+[m[32m        </ul>[m
[32m+[m[32m<!--        <div>{{this.iid}}</div>-->[m
         <DetailSwiper :top-images="topImages"/>[m
         <DetailBaseInfo :goods="goods"/>[m
         <DetailShopInfo :shop="shop"/>[m
[36m@@ -15,8 +22,10 @@[m
         <DetailCommentInfo ref="commen" :commentInfo="commentInfo"/>[m
         <Goodlist ref="good" :goods="recommend" />[m
       </Scroll>[m
[31m-      <backtop @click.native="backClick" v-show="isShowBackTop"/>[m
[31m-      <Detailbottonbar/>[m
[32m+[m[32m      <backtop @click.native="backClick"[m
[32m+[m[32m               v-show="isShowBackTop"[m
[32m+[m[32m                />[m
[32m+[m[32m      <Detailbottonbar @addjoin="addjoin"/>[m
     </div>[m
 </template>[m
 [m
[36m@@ -32,10 +41,9 @@[m [mimport DetailCommentInfo from "./childComps/DetailCommentInfo";[m
 import Goodlist from "components/content/goods/Goodlist";[m
 import Detailbottonbar from "./childComps/Detailbottonbar";[m
 [m
[31m-import backtop from "components/content/backtop/backtop";[m
 [m
 import {getdetail,Goods,Shop,GoodsParam,getrecommend} from "../../network/detail";[m
[31m-import {mixinorder} from "common/mixin"[m
[32m+[m[32mimport {mixinorder,backtops} from "common/mixin"[m
 import {debounce} from "common/utils"[m
 [m
 export default {[m
[36m@@ -50,8 +58,7 @@[m [mexport default {[m
     DetailCommentInfo,[m
     Detailbottonbar,[m
     Scroll,[m
[31m-    Goodlist,[m
[31m-    backtop[m
[32m+[m[32m    Goodlist[m
   },[m
   data() {[m
    return {[m
[36m@@ -70,7 +77,7 @@[m [mexport default {[m
      currentIndex: 0[m
    }[m
  },[m
[31m-  mixins:[mixinorder],[m
[32m+[m[32m  mixins:[mixinorder,backtops],[m
   created() {[m
     // 获取详情页id[m
     this.iid = this.$route.params.iid[m
[36m@@ -129,9 +136,9 @@[m [mexport default {[m
 [m
       this.getthemetops()[m
     },[m
[31m-    backClick() {[m
[31m-      this.$refs.scroll.scrollTo(0, 0,3000)[m
[31m-    },[m
[32m+[m[32m    // backClick() {[m
[32m+[m[32m    //   this.$refs.scroll.scrollTo(0, 0,3000)[m
[32m+[m[32m    // },[m
     contentScroll(position) {[m
       //判断backtop是否显示[m
       this.isShowBackTop = (-position.y) > 1000[m
[36m@@ -153,6 +160,16 @@[m [mexport default {[m
     },[m
     titleclick(index) {[m
       this.$refs.scroll.scrollTo(0,-this.themetops[index],500)[m
[32m+[m[32m    },[m
[32m+[m[32m    addjoin(){[m
[32m+[m[32m      const product = {};[m
[32m+[m[32m      product.image = this.topImages[0];[m
[32m+[m[32m      product.title = this.goods.title;[m
[32m+[m[32m      product.desc = this.goods.desc;[m
[32m+[m[32m      product.price = this.goods.oldPrice;[m
[32m+[m[32m      product.iid = this.iid;[m
[32m+[m	[32m    this.$store.commit('addjoin',product)[m
[32m+[m[32m      // this.$store.dispatch('addjoin',product)[m
     }[m
   },[m
   destroyed() {[m
[1mdiff --git a/src/views/detail/childComps/Detailbottonbar.vue b/src/views/detail/childComps/Detailbottonbar.vue[m
[1mindex 3b86fa1..a2d4e82 100644[m
[1m--- a/src/views/detail/childComps/Detailbottonbar.vue[m
[1m+++ b/src/views/detail/childComps/Detailbottonbar.vue[m
[36m@@ -15,7 +15,7 @@[m
       </div>[m
     </div>[m
     <div class="bar-item bar-right">[m
[31m-      <div class="cart">加入购物车</div>[m
[32m+[m[32m      <div class="cart" @click="join">加入购物车</div>[m
       <div class="buy">购买</div>[m
     </div>[m
   </div>[m
[36m@@ -23,7 +23,12 @@[m
 [m
 <script>[m
 export default {[m
[31m-name: "Detailbottonbar"[m
[32m+[m[32m name: "Detailbottonbar",[m
[32m+[m[32m  methods:{[m
[32m+[m[32m    join(){[m
[32m+[m[32m      this.$emit('addjoin')[m
[32m+[m[32m    }[m
[32m+[m[32m  }[m
 }[m
 </script>[m
 [m
[1mdiff --git a/src/views/home/Home.vue b/src/views/home/Home.vue[m
[1mindex 63e855b..e00ac2a 100644[m
[1m--- a/src/views/home/Home.vue[m
[1m+++ b/src/views/home/Home.vue[m
[36m@@ -34,9 +34,9 @@[m
   import TabControl from 'components/content/TabControl/TabControl'[m
   import Goodlist from 'components/content/goods/Goodlist'[m
   import scroll from "components/common/componets/Scroll"[m
[31m-  import backtop from "components/content/backtop/backtop"[m
   import {getHomeMultidata,getHomeGoods} from 'network/home'[m
   import {debounce} from "common/utils"[m
[32m+[m[32m  import {backtops} f