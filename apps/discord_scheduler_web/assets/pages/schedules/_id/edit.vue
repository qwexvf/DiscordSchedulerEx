<template>
  <div class="container">
    <h1>スケジュールを編集</h1>
    <b-card tag="article" class="mb-2">
      <b-form v-if="schedule" @submit="update">
        <b-form-group id="input-group-1" label="内容" label-for="input-1">
          <b-form-textarea id="textarea" v-model="schedule.message" rows="3" max-rows="6"></b-form-textarea>
        </b-form-group>

        <ImagePreview :image.sync="image" @update:image="val => mag = val" />

        <TimePicker
          :time.sync="time"
          @update:time="val => mag = val"
          :reservation_date.sync="reservation_date"
          @update:reservation_date="val => mag = val"
          :defaultDate="schedule.reservation_date"
          :defaultTime="time"
        />
        <div class="btn-group" role="group" aria-label="Basic example">
          <b-button type="submit" variant="primary">更新</b-button>
          <b-button type="reset" variant="danger" @click="onReset">キャンセル</b-button>
        </div>
      </b-form>
    </b-card>
  </div>
</template>

<script lang="ts">
import { Context } from "@nuxt/types";
import axios from "axios";

import { Component, Vue } from "nuxt-property-decorator";

import { ApiResult, Schedule } from "~/types/types";
import { zeroFill, convertTimeToInteger, getMomentTime } from "~/utils";
import ImagePreview from "~/components/ImagePreview.vue";
import TimePicker from "~/components/TimePicker.vue";

@Component({
  components: {
    ImagePreview,
    TimePicker
  }
})
export default class Edit extends Vue {
  private schedule: Schedule = new Schedule();

  private image: string = "";
  private reservation_date: Date = new Date();
  private time: string = "";

  async asyncData({ params: { id } }: Context): Promise<object> {
    const response = await axios.get(
      `${process.env.VUE_APP_API}/schedules/${id}`
    );

    const schedule = response.data.data;

    return {
      schedule: schedule,
      time: getMomentTime(schedule.reservation_date),
      image: schedule.image ? `${process.env.VUE_APP_BASE}${schedule.image}` : null
    };
  }

  async update(e: Event): Promise<void> {
    e.preventDefault();
    const id = this.$route.params.id;
    const [hour, min] = convertTimeToInteger(this.time);

    const date = new Date(this.reservation_date).setHours(hour, min);

    this.schedule.reservation_date = new Date(date).toISOString();

    let form = new FormData();

    form.append("schedule", JSON.stringify(this.schedule));

    let headers = {};

    form.append("image", this.image);
    headers = { "Content-Type": "multipart/form-data" };

    try {
      const response = await axios.patch(
        `${process.env.VUE_APP_API}/schedules/${id}`,
        form,
        headers
      );
      if (response.data) {
        this.schedule = response.data.data;
        this.$router.push("/");
      }
    } catch {
      console.log("error");
    }
  }

  onReset(e: Event): void {
    e.preventDefault();
    this.$router.push("/");
  }
}
</script>
