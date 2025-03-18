<template>
  <div class="container">
    <h2>房屋购买申请管理</h2>
    <el-button type="primary" @click="fetchBuyRequests">刷新记录</el-button>
    <el-table :data="buyRequests" style="width: 100%;" border v-loading="loading">
      <el-table-column prop="requestid" label="申请ID" width="100"></el-table-column>
      <el-table-column prop="houseid" label="房屋ID" width="100"></el-table-column>
      <el-table-column prop="landlordname" label="卖家"></el-table-column>
      <el-table-column prop="buyer" label="买家"></el-table-column>
      <el-table-column prop="requestDate" label="申请时间" width="180">
        <template slot-scope="scope">
          {{ formatDate(scope.row.requestDate) }}
        </template>
      </el-table-column>
      <el-table-column prop="status" label="状态" width="120">
        <template slot-scope="scope">
          {{ translateStatus(scope.row.status) }}
        </template>
      </el-table-column>
      <el-table-column label="操作" width="200">
        <template slot-scope="scope">
          <el-button
            type="primary"
            @click="openAppealDialog(scope.row)"
            :disabled="scope.row.status !== 'approved' || scope.row.isSubmitted"
          >提交申请</el-button>
        </template>
      </el-table-column>
    </el-table>

    <!-- 申请对话框 -->
    <el-dialog title="提交申请" :visible.sync="appealDialogVisible" width="30%">
      <el-form :model="appealForm" label-width="80px">
        <el-form-item label="申请类型">
          <el-radio-group v-model="appealForm.appealtype">
            <el-radio label="通过">通过</el-radio>
            <el-radio label="拒绝">拒绝</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="申请内容">
          <el-input type="textarea" v-model="appealForm.appealContent"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="appealDialogVisible = false">取消</el-button>
        <el-button type="primary" @click="submitAppeal">提交</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  data() {
    return {
      buyRequests: [], // 购买申请列表
      loading: false, // 加载状态
      appealDialogVisible: false, // 申诉对话框是否可见
      appealForm: {
        appealtype: "通过", // 默认申诉类型
        appealContent: "", // 申请内容
        requestid: null, // 当前申请ID
        isSubmitted: false, // 是否已提交
      },
    };
  },
  created() {
    this.fetchBuyRequests(); // 组件加载时自动获取数据
  },
  methods: {
    // 获取购买申请列表
    async fetchBuyRequests() {
      this.loading = true;
      try {
        const user = JSON.parse(localStorage.getItem("token"));
        if (!user || !user.username) {
          console.error("用户信息缺失或无效");
          this.$message.error("用户信息缺失，请重新登录");
          return;
        }
        const response = await request({
          method: "get",
          url: "/buy/requests/byLandlord",
          params: { landlordname: user.username },
        });
        // 确保赋值的是数组
        this.buyRequests = Array.isArray(response.data) ? response.data : [];
        // 初始化 isSubmitted 字段
        this.buyRequests.forEach(request => {
          request.isSubmitted = false;
        });
      } catch (error) {
        console.error("获取购买申请失败:", error);
        this.$message.error("获取购买申请失败，请稍后重试");
        this.buyRequests = []; // 报错时仍赋值为空数组
      } finally {
        this.loading = false;
      }
    },

    // 打开申请对话框
    openAppealDialog(row) {
      this.appealForm.requestid = row.requestid; // 设置当前申请ID
      this.appealDialogVisible = true; // 显示对话框
    },

    // 提交申请
   async submitAppeal() {
    try {
        const { appealtype, appealContent, requestid } = this.appealForm;

        if (!requestid || !appealtype || !appealContent) {
            this.$message.error("请填写完整的申诉信息");
            return;
        }

        const currentRequest = this.buyRequests.find(request => request.requestid === requestid);
        if (currentRequest && currentRequest.isSubmitted) {
            this.$message.error("该申请已经提交过，不能重复提交");
            return;
        }

        const response = await request({
            method: "post",
            url: "/contract/submitAppeal",
            params: {
                requestid: requestid,
                status: appealtype === "通过" ? "approved" : "rejected",
                order: appealContent, // 传递申请内容
            },
        });

        if (response.data && response.data.code === 1) {
            this.$message.success("申请提交成功，合同已生成");
            this.appealDialogVisible = false;
            currentRequest.isSubmitted = true;
            this.fetchBuyRequests();
        } else {
            this.$message.error("申请提交失败：" + (response.data ? response.data.msg : "未知错误"));
        }
    } catch (error) {
        console.error("请求失败：", error);
        this.$message.error("网络异常，请稍后重试");
    }
},

    // 格式化时间
    formatDate(dateString) {
      if (!dateString) return "";
      const date = new Date(dateString);
      const beijingTime = new Date(date.getTime() + 8 * 60 * 60 * 1000);
      return beijingTime.toISOString().replace("T", " ").substring(0, 19);
    },

    // 翻译状态
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