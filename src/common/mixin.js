import {debounce} from "./utils";

export const mixinorder ={
    mounted() {
        const refresh = debounce(this.$refs.scroll.refresh,30)
        this.getup = ()=>{
            refresh()
        }
        this.$bus.$on('itemimgload',this.getup)
    }
}