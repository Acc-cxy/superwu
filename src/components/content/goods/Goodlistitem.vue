<template>
    <div>
      <img :src="gooditem.show.img" alt="#">
      <div>
        <p>{{gooditem.title}}</p>
        <span>{{gooditem.orgPrice}}</span>
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
  }
}
</script>

<style scoped>

</style>