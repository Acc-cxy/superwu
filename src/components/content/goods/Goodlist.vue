<template>
    <div class="goods">
      {{goods}}
    </div>
</template>

<script>
export default {
  name: "Goodlist",
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

</style>