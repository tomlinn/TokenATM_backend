<template>
    <div>
        <el-table :data="tableData" border style="width: 100%">
            <el-table-column prop="id" label="student id" width="180">
            </el-table-column>
            <el-table-column prop="name" label="name" width="180">
            </el-table-column>
            <el-table-column prop="tokens" label="tokens">
            </el-table-column>
        </el-table>
        <el-button type="success" v-on:click="getCourses">成功按钮</el-button>
    </div>

</template>

<script>
export default {
    components: {},
    props: {},
    data() {
        return {
            tableData: [{
                id: '01',
                name: 'Henry',
                tokens: 2
            }, {
                id: '02',
                name: 'Tom',
                tokens: 5
            }, {
                id: '02',
                name: 'Sam',
                tokens: 5
            }, {
                id: '02',
                name: 'Jimmy',
                tokens: 5
            }]
        };
    },
    computed: {},
    watch: {},
    methods: {

        getCourses() {
            this.$http({
                url: this.$http.adornUrl('/token/courses'),
                method: 'get',
                
            }).then(({ data }) => {
                console.log(data)
            })
        }
    },
    created() { },
    mounted() {
    },
    beforeCreated() { },
    beforeMounted() { },
    beforeUpdate() { },
    updated() { },
    beforeDestory() { },
    destoryed() { },
    actived() { }
}

</script>
<style lang='css' scoped>

</style>