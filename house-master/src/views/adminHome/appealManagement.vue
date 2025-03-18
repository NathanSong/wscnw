<template>
  <div>
    <h2>申诉管理</h2>
    <!-- 申诉列表 -->
    <el-table :data="appealList" style="width: 100%">
      <el-table-column prop="appealid" label="申诉ID"></el-table-column>
      <el-table-column prop="houseid" label="房屋ID"></el-table-column>
      <el-table-column prop="appealer" label="申诉人"></el-table-column>
      <el-table-column prop="appealtype" label="申诉类型">
        <template slot-scope="scope">
          <el-tag v-if="scope.row.appealtype === '举报不实'" type="warning">举报不实</el-tag>
          <el-tag v-else-if="scope.row.appealtype === '已整改'" type="success">已整改</el-tag>
          <el-tag v-else type="info">{{ scope.row.appealtype }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="appealcontent" label="申诉内容"></el-table-column>
      <el-table-column prop="appealdate" label="申诉日期">
        <template slot-scope="scope">
          {{ formatDate(scope.row.appealdate) }} <!-- 格式化日期 -->
        </template>
      </el-table-column>
      <el-table-column label="状态">
        <template slot-scope="scope">
          <el-tag :type="getStatusTagType(scope.row.status)">
            {{ translateStatus(scope.row.status) }} <!-- 状态转换为中文 -->
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作">
        <template slot-scope="scope">
          <el-button
            type="primary"
            @click="handleAppeal(scope.row, 'approved')"
            :disabled="scope.row.status !== 'pending'"
          >
            通过
          </el-button>
          <el-button
            type="danger"
            @click="handleAppeal(scope.row, 'rejected')"
            :disabled="scope.row.status !== 'pending'"
          >
            未通过
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <!-- 分页栏 -->
    <div class="block">
      <el-pagination
        @size-change="handleSizeChange"
        @current-change="handleCurrentChange"
        :current-page="currentPage"
        :page-sizes="[5, 10, 15, 20]"
        :page-size="pageSize"
        layout="total, sizes, prev, pager, next, jumper"
        :total="total"
      >
      </el-pagination>
    </div>
  </div>
</template>

<script>
import request from "@/utils/request";

export default {
  data() {
    return {
      appealList: [], // 申诉列表
      currentPage: 1, // 当前页
      pageSize: 10, // 每页显示条数
      total: 0, // 总条数
    };
  },
  created() {
    this.getAppealList();
  },
  methods: {
    // 获取申诉列表
    async getAppealList() {
      try {
        const response = await request({
          method: "get",
          url: "/appeal/getAppealList",
          params: {
            page: this.currentPage,
            pageSize: this.pageSize,
          },
        });
        this.appealList = response.data.data.rows;
        this.total = response.data.data.total;
      } catch (error) {
        console.error("获取申诉列表失败:", error);
        this.$message.error("获取申诉列表失败，请稍后重试");
      }
    },
    // 改变每页显示条数
    handleSizeChange(val) {
      this.pageSize = val;
      this.getAppealList();
    },
    // 改变当前页
    handleCurrentChange(val) {
      this.currentPage = val;
      this.getAppealList();
    },
    // 处理申诉
    async handleAppeal(row, status) {
      try {
        const response = await request({
          method: "post",
          url: "/appeal/handleAppeal",
          data: { appealid: row.appealid, status },
        });
        if (response.data.code === 1) {
          this.$message.success(response.data.msg || "操作成功");
          this.getAppealList(); // 刷新列表
        } else {
          this.$message.error(response.data.msg || "操作失败");
        }
      } catch (error) {
        console.error("处理申诉失败:", error);
        this.$message.error("处理申诉失败，请稍后重试");
      }
    },
    // 根据状态返回标签类型
    getStatusTagType(status) {
      switch (status) {
        case "pending":
          return "info";
        case "approved":
          return "success";
        case "rejected":
          return "danger";
        default:
          return "danger";
      }
    },
    // 将状态转换为中文
    translateStatus(status) {
      switch (status) {
        case "pending":
          return "待处理";
        case "approved":
          return "已通过";
        case "rejected":
          return "未通过";
        default:
          return status;
      }
    },
    // 格式化日期
    formatDate(dateString) {
      if (!dateString) return ""; // 如果日期为空，返回空字符串
      const date = new Date(dateString);
      // 转换为北京时间（UTC+8）
      const beijingTime = new Date(date.getTime() + 8 * 60 * 60 * 1000);
      // 格式化为 YYYY-MM-DD HH:mm:ss
      return beijingTime.toISOString().replace("T", " ").substring(0, 19);
    },
  },
};
</script>

<style scoped>
h2 {
  margin-bottom: 20px;
}
</style>
