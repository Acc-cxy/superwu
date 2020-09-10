<template>
    <div class="goodsitem" @click="itemclick">
        <img :src="gooditem.show.img" alt="#" @load="imageload">
        <div>
          <p>{{gooditem.title}}</p>
          <span class="price">{{gooditem.orgPrice}}</span>
        </div>
    </div>
</template>

<script>
export default {
  name: "Goodlistitem",
  props:{
   gooditem:{
     type:Object,
     default(){
       return {}
     }
   }
  },
  methods:{
    imageload() {
      this.$bus.$emit('itemimgload')
    },
    itemclick() {
      this.$router.push('/detail/' + this.gooditem.iid)
    }
  }
}
</script>

<style scoped>
  .goodsitem{
    width: 50%;
    display: inline-block;
    padding: 10px;
  }

  .goodsitem img{
    width: 100%;
  }

  .goodsitem div p{
    width: 100%;
    overflow: hidden;
    white-space: nowrap;
    text-overflow: ellipsis;
    line-height: 2;
  }

  .goodsitem div span.price{
    color: var(--color-tint);
    text-align: center;
  }
</style>