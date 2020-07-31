<template>
  <div class="container fluid">
    <h1>スケジュールリスト</h1>
      <b-card
    tag="article"
    class="mb-2">
    <b-row>
      <b-col md="6" class="text-left">
        <b-form-group label-cols-sm="3" label="並び替え" class="mb-0">
          <b-input-group>
            <b-form-select v-model="filterBy">
              <option :value="null">予約一覧</option>
              <option value="true">送信済み</option>
            </b-form-select>
          </b-input-group>
        </b-form-group>
      </b-col>

      <b-col class="text-right">
        <nuxt-link class="btn btn-primary" to="/schedules/create">新規作成</nuxt-link>
      </b-col>
    </b-row>
    <b-row>
      <b-table
        striped
        hover
        selectable
        :items="schedulesFiltered"
        :fields="fields"
        :filter="filterBy"
        :filter-function="sortByKey"
        select-mode="multi"
        selectedVariant="success"
        @row-selected="rowSelected"
      >
        <template v-slot:cell(show_details)="row">
          <div class="btn-group btn-group-toggle" data-toggle="buttons">
            <button class="btn btn-primary" @click="sendSchedule(row)" v-if="!row.item.is_sent">送信</button>
            <button class="btn btn-secondary active" @click="editSchedule(row)">編集</button>
          </div>
        </template>

        <template v-slot:cell(reservation_date)="row">
          <div>{{ getFormatedMomentDate(row.item.reservation_date) }}</div>
        </template>

        <template v-slot:cell(selected)="row">
          <span v-if="row.rowSelected">✔</span>
        </template>
      </b-table>

      <button
        v-if="selected.length > 0"
        type="button"
        class="btn btn-primary"
        @click="deleteSelected"
      >選択したスケジュールを削除</button>
    </b-row>

    <b-row>
      <b-col md="6" class="my-1">
        <b-pagination
          v-model="params.page_number"
          :total-rows="params.total_entries"
          :per-page="params.page_size"
          aria-controls="my-table"
        ></b-pagination>
      </b-col>
    </b-row>
      </b-card>
  </div>
</template>

<script lang="ts">
import axios from "axios";
import { Component, Vue, Watch } from "nuxt-property-decorator";
import { getFormatedMomentDate } from "~/utils";
import { Schedule } from "~/types/types";

@Component
export default class extends Vue {
  private fields: object[] = [
    {
      key: "selected",
      label: "選択"
    },
    {
      key: "message",
      label: "内容"
    },
    {
      key: "reservation_date",
      label: "日付"
    },
    {
      key: "show_details",
      label: "操作"
    }
  ];

  getFormatedMomentDate = (date: string): string => {
    return getFormatedMomentDate(date);
  };

  private schedules: Schedule[] = [];
  private selected: [] = [];

  private filterBy: string | null = null;

  private params = {
    page_number: 1,
    is_sent: false,
    orderBy: "asc"
  };

  async asyncData() {
    const params: object = {
      page_number: 1,
      is_sent: false,
      orderBy: "asc"
    };

    const { data } = await axios.get(`${process.env.VUE_APP_API}/schedules`, {
      params: params
    });

    return {
      schedules: data.data,
      params: { ...params, ...data.params }
    };
  }

  get schedulesFiltered() {
    if (this.filterBy === null) {
      return this.schedules.filter(schedule => !schedule.is_sent);
    } else {
      return this.schedules.filter(schedule => schedule.is_sent);
    }
  }

  async fetchSchedules(): Promise<void> {
    const params = this.params;

    const response = await axios.get(`${process.env.VUE_APP_API}/schedules`, {
      params: params
    });

    this.schedules = response.data.data;
    this.params = { ...params, ...response.data.params };
  }

  linkGen(pageNum: number) {
    return pageNum === 1 ? "?" : `?page=${pageNum}`;
  }

  rowSelected(items: []) {
    this.selected = items;
  }

  async sendSchedule(row: any) {
    const confirm_check = confirm("次の処理を続けますか？");

    if (!confirm_check) return;

    await axios.post(
      `${process.env.VUE_APP_API}/schedules/${row.item.id}/send`
    );

    await this.fetchSchedules();
  }

  editSchedule(row: any) {
    this.$router.push({
      path: `/schedules/${row.item.id}/edit`,
      params: { id: row.item.id }
    });
  }

  sortByKey(row: any, filter: any) {
    if (filter === null) {
      return true;
    } else {
      return row.is_sent ? true : false;
    }
  }

  createSchedule() {
    this.$router.push({ name: "schedules_create" });
  }

  async deleteSelected(): Promise<void> {
    const confirm_check = confirm("次の処理を続けますか？");

    if (!confirm_check) return;

    await axios.post(`${process.env.VUE_APP_API}/schedules/deleteSelected`, {
      schedules: this.selected.map((item: any)=> item.id)
    });

    await this.fetchSchedules();
  }

  @Watch("params.page_number")
  async onParamsChange(newVal: number, oldVal: number) {
    this.params.page_number = newVal < 1 ? 1 : newVal;
    await this.fetchSchedules();
  }

  @Watch("filterBy")
  async onFilterByChange(newVal: any, _: any) {
    if (newVal) {
      this.params.is_sent = true;
    } else {
      this.params.is_sent = false;
    }

    await this.fetchSchedules();
  }
}
</script>
