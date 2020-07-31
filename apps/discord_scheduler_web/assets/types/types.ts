class Schedule {
    id: Number = 0
    is_sent: Boolean = false
    job_id: String = ""
    message: String = ""
    reservation_date: Date | string = ""
}

interface ApiResult {
    data: Schedule[]
    params: {
        page_number: number
        page_size: number
        total_entries: number
        total_pages: number
    }
}

export { Schedule, ApiResult }