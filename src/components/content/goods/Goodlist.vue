<template>
    <div class="goods">
         <!--eslint-disable-next-line-->
        <goodlistitem v-for="item in goods" :gooditem="item"/>
    </div>
</template>

<script>
    import Goodlistitem from './Goodlistitem'

    export default {
      name: "Goodlist",
      components:{
        Goodlistitem
      },
      props:{
        goods:{
          type:Array,
          default(){
            return []
          }
        }
      }
    }
</script>

<style scoped>
 .goods{
    display: flex;
    flex-wrap: wrap;
  }
</style>