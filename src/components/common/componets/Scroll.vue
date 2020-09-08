<template>
  <div class="wrapper" ref="wrapper">
    <div class="content">
      <slot></slot>
    </div>
  </div>
</template>

<script>
  import BScroll from 'better-scroll'

  export default {
    name:"scroll",
    props:{
      probeType: {
        type:Number,
        default:0
      }
    },
    data() {
      return {
        scroll:null
      }
    },
    mounted() {
      //创建bscroll对象
      this.scroll = new BScroll(this.$refs.wrapper, {
        click: true,mouseWheel: true,
        probeType: this.probeType
      })

      //监听滚动的位置
      this.scroll.on('scroll',(position) =>{
        // console.log(position)
        this.$emit('scroll',position)
      })

      console.log(this.scroll)
    },
    methods:{
      scrollTo(x,y,time=300){
        this.scroll.scrollTo(x,y,time)
      },
      refresh() {
        this.scroll.refresh()
      }
    }
  }
</script>

<style scoped>

</style>
