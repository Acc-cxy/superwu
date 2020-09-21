import Vue from 'vue'
import Vuex from 'vuex'

import actions from "@/store/actions";
import mutations from "@/store/mutations";
import getters from "@/store/getters";
Vue.use(Vuex)

const state = {
	cartlist:[]
}
const store = new Vuex.Store({
	state,
	mutations,
	actions,
	getters
})

export default store