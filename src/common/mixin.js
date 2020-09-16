import {debounce} from "./utils";
import backtop from "@/components/content/backtop/backtop";

export const mixinorder ={
    mounted() {
        const refresh = debounce(this.$refs.scroll.refresh,30)
        this.getup = ()=>{
            refresh()
        }
        this.$bus.$on('itemimgload',this.getup)
    }
}

export const backtops ={
    components:{
      backtop
    },
    data(){
        return{
            isShowBackTop: false
        }
    },
    methods:{
        backClick() {
             this.$refs.scroll.scrollTo(0, 0,300)
        }
    }
}