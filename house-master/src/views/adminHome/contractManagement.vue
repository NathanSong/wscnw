<template>
    <div class="container">
        <h2>合同管理</h2>
        
        <el-table :data="contracts" style="width: 100%;" border v-loading="loading">
            <el-table-column prop="contractid" label="合同ID" width="100"></el-table-column>
            <el-table-column prop="houseid" label="房屋ID" width="100"></el-table-column>
            <el-table-column prop="buyer" label="买家"></el-table-column>
            <el-table-column prop="seller" label="卖家"></el-table-column>
            <el-table-column prop="contractDate" label="合同日期" width="180">
                <template slot-scope="scope">
                    {{ formatDate(scope.row.contractDate) }}
                </template>
            </el-table-column>
            <el-table-column prop="order" label="合同内容"></el-table-column>
            <el-table-column prop="status" label="房东状态" width="120">
                <template slot-scope="scope">
                    {{ translateStatus(scope.row.status) }}
                </template>
            </el-table-column>
            <el-table-column prop="adminstatus" label="管理员状态" width="120">
                <template slot-scope="scope">
                    {{ translateStatus(scope.row.adminstatus) }}
                </template>
            </el-table-column>
            <el-table-column label="操作" width="200">
                <template slot-scope="scope">
                    <el-button
                        type="primary"
                        @click="updateContractStatus(scope.row.contractid, 'approved')"
                        :disabled="scope.row.status !== 'approved' || scope.row.adminstatus !== 'pending'"
                    >通过</el-button>
                    <el-button
                        type="danger"
                        @click="updateContractStatus(scope.row.contractid, 'rejected')"
                        :disabled="scope.row.status !== 'approved' || scope.row.adminstatus !== 'pending'"
                    >拒绝</el-button>
                </template>
            </el-table-column>
        </el-table>
    </div>
</template>

<script>
import request from "@/utils/request";

export default {
    data() {
        return {
            contracts: [],
            loading: false,
        };
    },
    created() {
        this.fetchContracts();
    },
    methods: {
        async fetchContracts() {
            this.loading = true;
            try {
                const response = await request({
                    method: "get",
                    url: "/contract/all",
                });
                this.contracts = response.data.data || [];
            } catch (error) {
                console.error("获取合同列表失败:", error);
                this.$message.error("获取合同列表失败，请稍后重试");
                this.contracts = [];
            } finally {
                this.loading = false;
            }
        },

        async updateContractStatus(contractid, status) {
            try {
                const response = await request({
                    method: "put",
                    url: "/contract/updateStatus",
                    params: { contractid, status, adminstatus: status },
                });

                if (response.data && response.data.code === 1) {
                    this.$message.success("合同状态更新成功");
                    this.fetchContracts();
                    if (status === "approved") {
                        this.updateHouseOwner(contractid);
                    }
                } else {
                    this.$message.error("合同状态更新失败：" + (response.data ? response.data.msg : "未知错误"));
                }
            } catch (error) {
                console.error("请求失败：", error);
                this.$message.error("网络异常，请稍后重试");
            }
        },

        async updateHouseOwner(contractid) {
    try {
        const contract = this.contracts.find((c) => c.contractid === contractid);
        if (!contract) {
            this.$message.error("未找到合同信息");
            return;
        }

        const response = await request({
            method: "put",
            url: "/contract/updateHouseOwner",
            params: {
                houseid: contract.houseid,
                statue: 3, // 将 status 改为 statue
                housename: contract.buyer,
                tenantname: contract.buyer,
            },
        });

        if (response.data && response.data.code === 1) {
            this.$message.success("房屋所有者更新成功");
        } else {
            this.$message.error("房屋所有者更新失败：" + (response.data ? response.data.msg : "未知错误"));
        }
    } catch (error) {
        console.error("请求失败：", error);
        this.$message.error("网络异常，请稍后重试");
    }
},

        formatDate(dateString) {
            if (!dateString) return "";
            const date = new Date(dateString);
            const beijingTime = new Date(date.getTime() + 8 * 60 * 60 * 1000);
            return beijingTime.toISOString().replace("T", " ").substring(0, 19);
        },

        translateStatus(status) {
            switch (status) {
                case "pending":
                    return "待处理";
                case "approved":
                    return "已通过";
                case "rejected":
                    return "已拒绝";
                default:
                    return status;
            }
        },
    },
};
</script>

<style scoped>
.container {
    padding: 20px;
}
</style>