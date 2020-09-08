export function debounce(func,delays) {
    let timer = null
    return function (...args){
        if(timer) clearTimeout(timer)
        timer = setTimeout(() =>{
            func.apply(this,args)
        },delays)
    }
}